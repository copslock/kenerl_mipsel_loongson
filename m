Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2009 17:54:27 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:43137 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492593AbZJXPyU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Oct 2009 17:54:20 +0200
Received: by pxi17 with SMTP id 17so219190pxi.21
        for <multiple recipients>; Sat, 24 Oct 2009 08:54:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=+MszvUpZzA2kReXNYdbTajx5kHrJSyj1TglWFr/psfk=;
        b=dP4oaNRmkmZW2Zc5GaUq1A/RVrdPSyhKCntZN4I5QeMm8eHN0WjYKq7BYUm5wBjohD
         T46nH/8xtwVMh55z9ydAYAqQiCqkqacMqq8G42kFDdUlhyHfJrqy03jv0yBEXZ/OiW//
         FtSzo+rYwc/kJG5gV2GXF6vH1zDTYecBYUijY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=dtAaqaeuOF60FhFDJIarXRlmBQWE/HzYtSyupcHuSAYp19fvteujctTHv82IW23Y6Q
         AIySyOT5QceQBMVaphOq+jv25oN3C5alkl3Gk7RzfQCFLS3NqL7JbhD98QWL2qlL0j6e
         Wski5lqYhsnduxi91wxjdRcnU6DiWtvpl/E44=
Received: by 10.115.101.15 with SMTP id d15mr18169929wam.200.1256399652834;
        Sat, 24 Oct 2009 08:54:12 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm2133785pxi.9.2009.10.24.08.54.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 08:54:11 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Add option to pass return address location to
 _mcount. Was: [PATCH -v4 4/9] tracing: add static function tracer support
 for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Richard Sandiford <rdsandiford@googlemail.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	GCC Patches <gcc-patches@gcc.gnu.org>,
	Adam Nemet <anemet@caviumnetworks.com>, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <87my3htau1.fsf@firetop.home>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <1256138686.18347.3039.camel@gandalf.stny.rr.com>
	 <1256233679.23653.7.camel@falcon> <4AE0A5BE.8000601@caviumnetworks.com>
	 <87y6n36plp.fsf@firetop.home> <4AE232AD.4050308@caviumnetworks.com>
	 <87my3htau1.fsf@firetop.home>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 24 Oct 2009 23:53:52 +0800
Message-Id: <1256399632.24957.75.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Sat, 2009-10-24 at 10:12 +0100, Richard Sandiford wrote:
> Thanks for the patch.
[...]
> > How about this patch, I think it does what you suggest.
> >
> > When we pass -pg -mmcount-raloc, the address of the return address 
> > relative to sp is passed in $12 to _mcount.  If the return address is 
> > not saved, $12 will be zero.  I think this will work as registers are 
> > never saved with an offset of zero.  $12 is a temporary register that is 
> > not part of the ABI.
> 
> Hmm, well, the suggestion was to pass a pointer rather than an offset,
> but both you and Wu Zhangjin seem to prefer the offset.  Is there a
> reason for that?  I suggested a pointer because
> 
>   (a) they're more C-like
>   (b) they're just as quick and easy to compute
>   (c) MIPS doesn't have indexed addresses (well, except for a few
>       special cases) so the callee is going to have to compute the
>       pointer at some stage anyway
> 

Agree with you.

if not with -fno-omit-frame-pointer, we also need to calculate the frame
pointer, and then plus it with the offset. with pointer, we can get it
directly, but it may need a more instruction(lui..., addiu...) for
loading the pointer. of course, at last, the pointer will save more time
for us :-)

so, David, could you please use pointer instead? and then I will test it
asap(cloning the latest gcc currently). thanks!

> (It sounds from Wu Zhangjin's reply like he'd alread suggested the
> offset thing before I sent my message.  If so, sorry for not using
> that earlier message as context.)
> 

It doesn't matter, Seems at that time, you were not added in the CC
list, but added by David Daney later.

> > +  if (TARGET_RALOC)
> > +    {
> > +      /* If TARGET_RALOC load $12 with the offset of the ra save
> > +	 location.  */
> > +      if (mips_raloc_in_delay_slot_p())
> > +	emit_small_ra_offset = 1;
> > +      else
> > +	{
> > +	  if (Pmode == DImode)
> > +	    fprintf (file, "\tdli\t%s,%d\t\t# offset of ra\n", reg_names[12],
> > +		     cfun->machine->frame.ra_fp_offset);
> > +	  else
> > +	    fprintf (file, "\tli\t%s,%d\t\t# offset of ra\n", reg_names[12],
> > +		     cfun->machine->frame.ra_fp_offset);
> > +	}
> > +    }
> 
> We shouldn't need to do the delay slot dance.  With either the pointer
> ((D)LA) or offset ((D)LI) approach, the macro won't use $at, so we can
> insert the new code immediately before the jump, leaving the assembler
> to fill the delay slot.  This is simpler and should mean that the delay
> slot gets filled more often in the multi-insn-macro cases.
> 
> Looks good otherwise, but I'd be interested in other suggestions for
> the option name.  I kept misreading "raloc" as a typo for "reloc".
> 

The same misreading to me, what about -mmcount-ra-loc? add one "-", or
-mcount-ra-location?

BTW: Just made dynamic function tracer for MIPS support module tracing
with the help of -mlong-calls. after some more tests, I will send it as
-v5 revision later. hope the -v6 revision work with this new feature of
gcc from David Daney.

Regards,
	Wu Zhangjin
