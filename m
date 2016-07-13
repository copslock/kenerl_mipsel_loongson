Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 16:07:40 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:21058 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993243AbcGMOHc4cpm4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 16:07:32 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u6DE7K0u019463
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 13 Jul 2016 14:07:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u6DE7KGT011566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 13 Jul 2016 14:07:20 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u6DE7I3I013432;
        Wed, 13 Jul 2016 14:07:20 GMT
Received: from mwanda (/154.0.139.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jul 2016 07:07:18 -0700
Date:   Wed, 13 Jul 2016 17:07:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     markos.chandras@imgtec.com, Matt Evans <matt@ozlabs.org>
Cc:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: [bug report] MIPS: net: Add BPF JIT
Message-ID: <20160713140711.GA8984@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello Markos Chandras,

The patch c6610de353da: "MIPS: net: Add BPF JIT" from Apr 8, 2014,
leads to the following static checker warning:

	arch/mips/net/bpf_jit.c:1185 build_body()
	warn: potential off by one 'ctx->offsets[]' limit 'prog->len'

arch/mips/net/bpf_jit.c
   652  static int build_body(struct jit_ctx *ctx)
   653  {
   654          const struct bpf_prog *prog = ctx->skf;
   655          const struct sock_filter *inst;
   656          unsigned int i, off, condt;
   657          u32 k, b_off __maybe_unused;
   658          u8 (*sk_load_func)(unsigned long *skb, int offset);
   659  
   660          for (i = 0; i < prog->len; i++) {
   661                  u16 code;
   662  
   663                  inst = &(prog->insns[i]);
   664                  pr_debug("%s: code->0x%02x, jt->0x%x, jf->0x%x, k->0x%x\n",
   665                           __func__, inst->code, inst->jt, inst->jf, inst->k);
   666                  k = inst->k;
   667                  code = bpf_anc_helper(inst);
   668  
   669                  if (ctx->target == NULL)
   670                          ctx->offsets[i] = ctx->idx * 4;

We have this so we don't need the other assignment.

   671  
   672                  switch (code) {

[ snipped big switch statement ]

  1176                  default:
  1177                          pr_debug("%s: Unhandled opcode: 0x%02x\n", __FILE__,
  1178                                   inst->code);
  1179                          return -1;
  1180                  }
  1181          }
  1182  
  1183          /* compute offsets only during the first pass */
  1184          if (ctx->target == NULL)
  1185                  ctx->offsets[i] = ctx->idx * 4;

i is always one step beyond the end of the array here.

  1186  
  1187          return 0;
  1188  }

That arm and powerpc implementations have the same issue.

regards,
dan carpenter
