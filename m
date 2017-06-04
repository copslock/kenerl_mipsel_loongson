Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jun 2017 23:44:32 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:36015
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993944AbdFDVo0L-Gx5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Jun 2017 23:44:26 +0200
Received: by mail-wr0-x244.google.com with SMTP id e23so4731918wre.3;
        Sun, 04 Jun 2017 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HDu6b1Rsx/DquwtmP4CbkKPNBTV4XyeAFNU7boV5mPs=;
        b=U7RZfxA4PexjZsWv4LJ0NO2CPOepjiO8/wPSocW9uC4EOqJ/qRtWUHGauUoXxPxs1A
         0UdmjXUR+dH5w8wql9jfzSKu2gsfkYq4an0M8L7BZ9H3MSBiLEPZ8ITw7kbLc5t0M7ba
         iti5nOV7aAEfPZ75rHjRDvrn1d2MnyTqCpUzJldOcy/PWZMuIBMEMKI2rwumRwbiHe9c
         4yaJUx3MJKcUe8hAM6HtfrKJ0J9MbIKSVxuHBtWHcyfYYAzFVlOwduuJgTRIgeTQtGZe
         AcNY+WzZ9zchEQhqJmnaqSJxehakC/A/0GRPG4Az/2DTmdhGVelpZp/qnYxnAkGyFUyy
         b85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HDu6b1Rsx/DquwtmP4CbkKPNBTV4XyeAFNU7boV5mPs=;
        b=cpnXbkP4/wc6wUpW+k2tmYMm36BT80gTfiYpfoYUEMdNv1ziTqpnWuIvJ4Witgj8G+
         Vx2FSo0X2UOz26bq9n6ZccJEeIAUaQpkoN991Ghq5d0Z7Rao7p+HepTx6gd/kOW5fpW4
         pdUHB7Q7T7qDSbuAb17NkbTSmvJ6S+RpDB5CX6P/rWAzznnScgMAl6HD6nW3vA5lpN6r
         DSR+j7FtY9BJlKyFzAP4eGb53JeG4MjMo3ioALZ/DHQsvLx5UUXf0CxnHYE18bLdkLoX
         aZZQYLO77HQTqsIxlhYPjVLY6/aTojVMdJq5EuLTLuhCT5dLMHUSYpEVv4j+MGSVg+Ld
         J6ww==
X-Gm-Message-State: AODbwcAUn8e7U9AVBb6h8TpgZuBLkj0iY35K/xycjC1yUOvFiFBbiypU
        NoEve5VYS8U/yQ==
X-Received: by 10.223.135.227 with SMTP id c32mr13893523wrc.10.1496612660901;
        Sun, 04 Jun 2017 14:44:20 -0700 (PDT)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id p76sm9459923wma.15.2017.06.04.14.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Jun 2017 14:44:20 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mips@linux-mips.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] net: sched: fix mips build failure
Date:   Sun,  4 Jun 2017 22:44:13 +0100
Message-Id: <1496612653-12419-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

The build of mips ar7_defconfig was failing with the error:
../net/sched/act_api.c: In function 'tcf_action_goto_chain_init':
../net/sched/act_api.c:37:18: error:
	implicit declaration of function 'tcf_chain_get'
	[-Werror=implicit-function-declaration]

../net/sched/act_api.c: In function 'tcf_action_goto_chain_fini':
../net/sched/act_api.c:45:2: error:
	implicit declaration of function 'tcf_chain_put'
	[-Werror=implicit-function-declaration]

Add two inline helpers for the case where CONFIG_NET_CLS is not enabled.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

The build log of the latest linux-next is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/238623031/

 include/net/pkt_cls.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 537d0a0..c34ade5 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -29,6 +29,17 @@ int tcf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 
 #else
 static inline
+struct tcf_chain *tcf_chain_get(struct tcf_block *block,
+				u32 chain_index, bool create)
+{
+	return NULL;
+}
+
+static inline void tcf_chain_put(struct tcf_chain *chain)
+{
+}
+
+static inline
 int tcf_block_get(struct tcf_block **p_block,
 		  struct tcf_proto __rcu **p_filter_chain)
 {
-- 
2.7.4
