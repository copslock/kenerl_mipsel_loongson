Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 22:15:01 +0000 (GMT)
Received: from server212.com ([IPv6:::ffff:203.194.159.163]:26784 "HELO
	server212.com") by linux-mips.org with SMTP id <S8225507AbUCYWPA>;
	Thu, 25 Mar 2004 22:15:00 +0000
Received: (qmail 23933 invoked by uid 501); 25 Mar 2004 22:16:09 -0000
Message-ID: <20040325221609.8755.qmail@server212.com>
Reply-To: "wlacey" <wlacey@goldenhindresearch.com>
From: "wlacey" <wlacey@goldenhindresearch.com>
To: linux-mips@linux-mips.org
Subject: RPC: exit -512
Date: Thu, 25 Mar 2004 22:16:09 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_b394d83a776f726d2e7d44e916026d282"
X-Mailer: WebMail 2.3
X-Originating-IP: 65.60.157.128
X-Originating-Email: wlacey@goldenhindresearch.com
Return-Path: <wlacey@goldenhindresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wlacey@goldenhindresearch.com
Precedence: bulk
X-list: linux-mips

--_b394d83a776f726d2e7d44e916026d282
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

HI,

I'm trying to bring up a 2.4.18 kernel on a tx4925 using an NFS'ed root filesystem. In the process of mounting root, the actual mount request RPC call returns a -512 which is -ERESTARTSYS from function __rpc_execute() in file net/sunrpc/sched.c.

About line 622...


--_b394d83a776f726d2e7d44e916026d282
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

HI,<br>
<br>
I'm trying to bring up a 2.4.18 kernel on a tx4925 using an NFS'ed root filesystem. In the process of mounting root, the actual mount request RPC call returns a -512 which is -ERESTARTSYS from function __rpc_execute() in file net/sunrpc/sched.c.<br>
<br>
About line 622...<br>
<br>


--_b394d83a776f726d2e7d44e916026d282--
