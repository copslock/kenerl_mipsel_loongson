Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 17:09:21 +0100 (BST)
Received: from n7.bullet.mud.yahoo.com ([216.252.100.58]:64341 "HELO
	n7.bullet.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20024120AbXJAQJL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 17:09:11 +0100
Received: from [209.191.108.97] by n7.bullet.mud.yahoo.com with NNFMP; 01 Oct 2007 16:07:50 -0000
Received: from [209.191.119.183] by t4.bullet.mud.yahoo.com with NNFMP; 01 Oct 2007 16:07:50 -0000
Received: from [127.0.0.1] by omp106.mail.mud.yahoo.com with NNFMP; 01 Oct 2007 11:32:24 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 781489.37541.bm@omp106.mail.mud.yahoo.com
Received: (qmail 87513 invoked by uid 60001); 1 Oct 2007 10:51:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=yH0p7Xa53FkejCSpJUeKL3g42t+2nG6tFElL5c8IsJMCXKsUovDpNTAKrCBNXC0yQJcFnShPZtB54q0NbKDYVn9UETirap+cTUSZ5peNoLjY0VR2jBPS0OzvA/N6g/32sOgKmlZLWFqzSRznRagVWnKBkMozHAeKJAPzYOg1Rd8=;
X-YMail-OSG: .bDNJ.cVM1nCsqTQWPXUQNTfz8Q0objiHDXBlBFh1kqOdT6YeEiXu6JJIK0gLRMBwg--
Received: from [199.239.167.162] by web8404.mail.in.yahoo.com via HTTP; Mon, 01 Oct 2007 11:51:21 BST
Date:	Mon, 1 Oct 2007 11:51:21 +0100 (BST)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
Subject: Re: linux cache routines for Write-back cache policy on  MIPS24KE
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0710011121300.20679@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <302271.86305.qm@web8404.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

Hi Geert,

Thanks for your repsonse.

In linux-2.6.18 (for MIPS24KE processor):
suppose if i want to do flush only then which API i
should use?
Similarly, if i want to do invalidation only which API
i should use?

Thanks again.

Regards,
Veerasena.
--- Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, 1 Oct 2007, veerasena reddy wrote:
> > I have ported Linux-2.6.18 kernel on MIPS24KE
> > processor. I am using write back cache policy.
> > 
> > Could you please guide me under what cases the
> below
> > cache API's are being used:
> > - dma_cache_wback_inv() : Could you explain  what
> > exactly this function does
> 
> It does both write back and invalidate.
> 
> > - dma_cache_wback() : This function write back the
> > cache data to memory
> > - dma_cache_inv  : This function invalidate the
> cache
> > tags. so subsequent access will fetch from memory.
> 
> Note that 2.6.18 is old. The above functions are
> intended to be removed.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond
> ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I
> call myself a hacker. But
> when I'm talking to journalists I just say
> "programmer" or something like that.
> 							    -- Linus Torvalds
> 



      Get the freedom to save as many mails as you wish. To know how, go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
