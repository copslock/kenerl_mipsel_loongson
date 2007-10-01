Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 19:48:57 +0100 (BST)
Received: from n6.bullet.mud.yahoo.com ([216.252.100.57]:13493 "HELO
	n6.bullet.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021761AbXJASs0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 19:48:26 +0100
Received: from [68.142.194.243] by n6.bullet.mud.yahoo.com with NNFMP; 01 Oct 2007 18:47:04 -0000
Received: from [209.191.119.164] by t1.bullet.mud.yahoo.com with NNFMP; 01 Oct 2007 18:47:04 -0000
Received: from [127.0.0.1] by omp103.mail.mud.yahoo.com with NNFMP; 01 Oct 2007 16:36:33 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 364363.43167.bm@omp103.mail.mud.yahoo.com
Received: (qmail 96203 invoked by uid 60001); 1 Oct 2007 12:13:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=WJZfArM1nFJ48nLF8v7s7JncM0/nshX7nOj1MfLlSRPboVcdskjfnpLKx1l9iTlbaHa3hvZYYqobJrpQsCXCmCMsfc7saFoy+IiliwAYlylzH8DxwNkT+d6fYp+izB6zBGNyWDuL2NWyMZBSJzslKFapy/b0lJj6osrHjqS7rPE=;
X-YMail-OSG: seURp90VM1lCQ9NKSyRWx4lTNpcVIUWDCYzqjgtlf9Y62jSectMGExqe.Mdiqp3y2mDz8iIyApuLugd88KlDl_bJCgoLCGoRYI0ndEW9vBk3e0Us1Y6_dqpS0IbJXQ--
Received: from [199.239.167.162] by web8402.mail.in.yahoo.com via HTTP; Mon, 01 Oct 2007 13:13:47 BST
Date:	Mon, 1 Oct 2007 13:13:47 +0100 (BST)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
Subject: Re: linux cache routines for Write-back cache policy on  MIPS24KE
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0710011341320.20679@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <900355.95714.qm@web8402.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

hi Geert,

here i mean 'flush' is 'write-back only'

Regards,
Veerasena.
--- Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, 1 Oct 2007, veerasena reddy wrote:
> > In linux-2.6.18 (for MIPS24KE processor):
> > suppose if i want to do flush only then which API
> i
> > should use?
> 
> `flush' is fuzzy terminology: some people mean
> invalidate, others mean
> write back, others mean both.
> 
> > Similarly, if i want to do invalidation only which
> API
> > i should use?
> 
> dma_cache_inv().
> 
> > --- Geert Uytterhoeven <geert@linux-m68k.org>
> wrote:
> > 
> > > On Mon, 1 Oct 2007, veerasena reddy wrote:
> > > > I have ported Linux-2.6.18 kernel on MIPS24KE
> > > > processor. I am using write back cache policy.
> > > > 
> > > > Could you please guide me under what cases the
> > > below
> > > > cache API's are being used:
> > > > - dma_cache_wback_inv() : Could you explain 
> what
> > > > exactly this function does
> > > 
> > > It does both write back and invalidate.
> > > 
> > > > - dma_cache_wback() : This function write back
> the
> > > > cache data to memory
> > > > - dma_cache_inv  : This function invalidate
> the
> > > cache
> > > > tags. so subsequent access will fetch from
> memory.
> > > 
> > > Note that 2.6.18 is old. The above functions are
> > > intended to be removed.
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
> 



      Forgot the famous last words? Access your message archive online at http://in.messenger.yahoo.com/webmessengerpromo.php
