Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 05:54:05 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.184]:37836
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225218AbVCPFxt>; Wed, 16 Mar 2005 05:53:49 +0000
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DBRTY-0007at-00; Wed, 16 Mar 2005 06:53:48 +0100
Received: from [213.39.155.219] (helo=c155219.adsl.hansenet.de)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DBRTX-0007cE-00; Wed, 16 Mar 2005 06:53:48 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: need help with CompactFlash/PCMCIA
Date:	Wed, 16 Mar 2005 06:51:42 +0100
User-Agent: KMail/1.7.1
References: <200503151245.15920.eckhardt@satorlaser.com> <42371C05.7060401@embeddedalley.com>
In-Reply-To: <42371C05.7060401@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503160651.42705.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Tuesday 15 March 2005 18:31, Pete Popov wrote:
> > 2. How can I find out if it's looking at the right addresses? I just need
> > some kind of register which I can probe to find out if the device is
> > where I think it should be.
> >
> > Hmm, in fact I'd be happy about _any_ hint the would get me further. I'm
> > slightly desparate...
>
> Start with the low level routines that detect the card and set the voltage
> levels. When you plug in the card, is it detected? Are you setting the
> correct voltages? What happens next -- is the card at least recognized by 
> the cardmgr, which means that the attribute memory is read correctly?

I don't see any message that something is found, nor can I definitely say 
where an error happens. I mainly see two parts: one where cardservices are 
initialised and one where the driver registers itself. The former doesn't say 
it found anything at all, maybe that is already the problem... I'll 
investigate further.

Could you post the relevant messages of a working system, so I could compare 
that?

Hmmm, I just had a scary thought: I don't have any userspace programs running 
yet, meaning also no cardmgr, because I intend to boot from that CF card - is 
that possible at all? FYI, I don't need any hotplugging at all.

thanks

Uli
