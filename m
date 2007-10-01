Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 21:33:39 +0100 (BST)
Received: from n7.bullet.mud.yahoo.com ([216.252.100.58]:39785 "HELO
	n7.bullet.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021983AbXJAUda (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 21:33:30 +0100
Received: from [68.142.194.244] by n7.bullet.mud.yahoo.com with NNFMP; 01 Oct 2007 20:33:23 -0000
Received: from [209.191.119.153] by t2.bullet.mud.yahoo.com with NNFMP; 01 Oct 2007 20:33:23 -0000
Received: from [127.0.0.1] by omp100.mail.mud.yahoo.com with NNFMP; 01 Oct 2007 20:08:15 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 842743.27969.bm@omp100.mail.mud.yahoo.com
Received: (qmail 48437 invoked by uid 60001); 1 Oct 2007 12:10:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=JFI93gjpzOHlXrYO0qKiBrK2exRN0OUN5mgune/EHusbnjKGeS2+sEvK9Tn0eMPo1KvwogV0XtXLOa8+OtabFNg6kjPzE6/DBzH/XSkEeYxjkQACFOyyLaFoaEyO6w9yo/TykbbTHV1rzLQEClIKfNh61EHkhDIwEPLSFCcJVpE=;
X-YMail-OSG: 2Ig8bTcVM1nO9td6myIxXt9.FpWVrwmpuK_jDH2VK_Z13tLNAiMLCRCEa2vgXw9UmqssKi2L8wJOBb2MetWIWOxLM0VENOwBoLeO8r.4zPTX.bC6fUVqfh4iVQ--
Received: from [199.239.167.162] by web8403.mail.in.yahoo.com via HTTP; Mon, 01 Oct 2007 13:10:59 BST
Date:	Mon, 1 Oct 2007 13:10:59 +0100 (BST)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
Subject: Re: linux cache routines for Write-back cache policy on  MIPS24KE
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20071001105954.GB23647@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <535696.48077.qm@web8403.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Thanks for the reply.

Is there any problem if we use the below API's in
linxu-2.6.18 
  - dma_cache_wback_inv()
  - dma_cache_wback()
  - dma_cache_inv()

functionality wise, especially in r4k.c i dont see any
difference between the implementation of these APIs.

Can we apply the 2.6.24 patch to kill these APIs on
2.6.18 kernel? In this case what APIs i can use for
writeback, invalidation or both?

I couldn't find any info. related to the above API in
DMA-API.txt. Could you please give some pointers on
the usage/working of these APIs.

Regards,
Veerasena.

--- Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Oct 01, 2007 at 10:04:32AM +0100, veerasena
> reddy wrote:
> 
> > I have ported Linux-2.6.18 kernel on MIPS24KE
> > processor. I am using write back cache policy.
> > 
> > Could you please guide me under what cases the
> below
> > cache API's are being used:
> > - dma_cache_wback_inv() : Could you explain  what
> > exactly this function does
> > - dma_cache_wback() : This function write back the
> > cache data to memory
> > - dma_cache_inv  : This function invalidate the
> cache
> > tags. so subsequent access will fetch from memory.
> > 
> > Once I looked the above function definitions in
> > linux-2.6.18/arch/mips/mm/c-r4k.c.
> > All these function's implemetation are same except
> > bc_wbak_inv() is called in both
> dma_cache_wback-inv()
> > and dma_cache_wback(), where as bc_inv() is called
> in
> > case of dma_cache_inv.
> > 
> > Also, bc_inv()/bc_wbak_inv are define as null
> > implementation for R4000.
> > That means all three functions are doing same
> > functionality in case of R4000.
> > 
> > What are the difference between these three
> functions.
> > Under what cases these functions are used. 
> 
> An internal only interface to be used with I/O cache
> coherency.
> 
> > Please guide me if you have any links which will
> > explain these API's.
> 
> Easy answer, don't use them, for 2.6.24 I've queued
> a patch to kill this
> API.  Documentation/DMA-API.txt documents how to
> properly deal with I/O
> coherency in Linux.
> 
>   Ralf
> 



      Save all your chat conversations. Find them online at http://in.messenger.yahoo.com/webmessengerpromo.php
