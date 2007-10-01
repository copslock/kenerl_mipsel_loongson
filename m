Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 10:11:48 +0100 (BST)
Received: from n6.bullet.mud.yahoo.com ([216.252.100.57]:36949 "HELO
	n6.bullet.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022052AbXJAJLj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 10:11:39 +0100
Received: from [68.142.194.244] by n6.bullet.mud.yahoo.com with NNFMP; 01 Oct 2007 09:10:17 -0000
Received: from [209.191.119.163] by t2.bullet.mud.yahoo.com with NNFMP; 01 Oct 2007 09:10:17 -0000
Received: from [127.0.0.1] by omp102.mail.mud.yahoo.com with NNFMP; 01 Oct 2007 09:10:17 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 130687.14103.bm@omp102.mail.mud.yahoo.com
Received: (qmail 35417 invoked by uid 60001); 1 Oct 2007 09:04:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=lUVapiL1EKJnQozhcUV8Go1a4BzqxjAdmJst7d0WMrogji9z0oVMERAXx+UfrPvswLbvpLf0XOZ+w1tVryHaTjv8c3sM6Zv/onTj/4igs0/ESJNfAOBRkcDZNRbsLhMZpz2WEjS1p0SEIvzxLxc4AnKs0gM6tTACvHc1QatGQFg=;
X-YMail-OSG: OvqjJSIVM1k_lSVRAynBOP_A43iN1H_VzB1zKuh_Bsd6U_rNdd8hCJ7YDDBBBSvEl6mpv3CG8S3CblaZVZjTJfBgdqq9I4fWKvzRWeEnf3bX9SghKLoaIpCUk2P1HQ--
Received: from [199.239.167.162] by web8401.mail.in.yahoo.com via HTTP; Mon, 01 Oct 2007 10:04:32 BST
Date:	Mon, 1 Oct 2007 10:04:32 +0100 (BST)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
Subject: linux cache routines for Write-back cache policy on  MIPS24KE
To:	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <119374.35234.qm@web8401.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

Hi,

I have ported Linux-2.6.18 kernel on MIPS24KE
processor. I am using write back cache policy.

Could you please guide me under what cases the below
cache API's are being used:
- dma_cache_wback_inv() : Could you explain  what
exactly this function does
- dma_cache_wback() : This function write back the
cache data to memory
- dma_cache_inv  : This function invalidate the cache
tags. so subsequent access will fetch from memory.

Once I looked the above function definitions in
linux-2.6.18/arch/mips/mm/c-r4k.c.
All these function's implemetation are same except
bc_wbak_inv() is called in both dma_cache_wback-inv()
and dma_cache_wback(), where as bc_inv() is called in
case of dma_cache_inv.

Also, bc_inv()/bc_wbak_inv are define as null
implementation for R4000.
That means all three functions are doing same
functionality in case of R4000.

What are the difference between these three functions.
Under what cases these functions are used. 

Please guide me if you have any links which will
explain these API's.
Thanks in advance.

Regards,
Veerasena.


      Forgot the famous last words? Access your message archive online at http://in.messenger.yahoo.com/webmessengerpromo.php
