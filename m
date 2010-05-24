Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 10:37:38 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:64273 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491030Ab0EXIhe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 May 2010 10:37:34 +0200
Received: by pvg2 with SMTP id 2so212260pvg.36
        for <multiple recipients>; Mon, 24 May 2010 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=6kngJtcj59Bhv9z7uc6saT8SauO+83PKZIQb9Or6b/g=;
        b=uCEJFhNrpSccHy+LLecILjmGOYdkI+K5+I5yMjczrKJacmCz36SS3//DYKWLPncWBy
         mtrtwF/QQUS1DLtOu/OJmAOwUIvpl6MDgZdnyrn/95WGTKjIJMD6FpnfC/lXFSB/AYTn
         KRmh+xvpJZPf7/YPtQ+0Qin1vJZcExX2PEfZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=AI/aklckRtiw7S/eWnB7cKrFCAauX3WLrPujY/a7fhNqKHXUVipHcrQR1KhklG6PBd
         wQ/FWp7ZRoXFgafnHfuy0uP5HN1BFEknHtK0MzkiHoBcOHDcQxGxn2XmwAA+Cehplhdq
         +qE8fCVDjr72NHGMaXqYxsz8+15H9g7MmIUV4=
Received: by 10.114.250.6 with SMTP id x6mr4617677wah.33.1274690246720;
        Mon, 24 May 2010 01:37:26 -0700 (PDT)
Received: from stratos (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id n32sm36541353wae.22.2010.05.24.01.37.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 01:37:25 -0700 (PDT)
Date:   Mon, 24 May 2010 15:45:08 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>,
        netdev <netdev@vger.kernel.org>
Subject: net/dccp: expansion of error code size
Message-Id: <20100524154508.10a40589.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.16.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Because MIPS's EDQUOT value is 1133(0x46d).
It's larger than u8.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 net/dccp/input.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/dccp/input.c b/net/dccp/input.c
index 58f7bc1..6beb6a7 100644
--- a/net/dccp/input.c
+++ b/net/dccp/input.c
@@ -124,9 +124,9 @@ static int dccp_rcv_closereq(struct sock *sk, struct sk_buff *skb)
 	return queued;
 }
 
-static u8 dccp_reset_code_convert(const u8 code)
+static u16 dccp_reset_code_convert(const u8 code)
 {
-	const u8 error_code[] = {
+	const u16 error_code[] = {
 	[DCCP_RESET_CODE_CLOSED]	     = 0,	/* normal termination */
 	[DCCP_RESET_CODE_UNSPECIFIED]	     = 0,	/* nothing known */
 	[DCCP_RESET_CODE_ABORTED]	     = ECONNRESET,
@@ -148,7 +148,7 @@ static u8 dccp_reset_code_convert(const u8 code)
 
 static void dccp_rcv_reset(struct sock *sk, struct sk_buff *skb)
 {
-	u8 err = dccp_reset_code_convert(dccp_hdr_reset(skb)->dccph_reset_code);
+	u16 err = dccp_reset_code_convert(dccp_hdr_reset(skb)->dccph_reset_code);
 
 	sk->sk_err = err;
 
-- 
1.7.1
