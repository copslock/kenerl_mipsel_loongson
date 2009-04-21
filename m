Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 15:12:27 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.145]:6744 "EHLO
	ey-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S29039707AbZDUOKX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2009 15:10:23 +0100
Received: by ey-out-1920.google.com with SMTP id 13so457431eye.54
        for <linux-mips@linux-mips.org>; Tue, 21 Apr 2009 07:10:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=3QIeKNTfCH5cxk4/brs2Q1wBYZk3W9yIANING2w5MqY=;
        b=iraSoFLh15AqsIU57Z9pH0hJXwhqBzZxD7WLaDlPT4yPlggy1C6jas40Cqxj3tOghE
         Hk/E1MVodiTI6g8vAsz7eT8sK1XCADCjzvfJnhYUAMVXxQs7NBcFHgCLWrBAIbs2+F0G
         JtLKKxeAK0RZ/iYVAyH2MWNw/k1s+tC5bW/4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=rTV7dq6eAnVrMaudAGJ0w4WFbC8q1OcsMB71wUNKxU4810zyTZmn8/TItKybMhFKk6
         QVO72SXb6jyQb5sw4mtEx25QCUbELgr+6LiKocNOGMcqAKmIxVMvuQfaEIUo2NdpXvx1
         wiAF3A64SItEHRwx4+yDDOiIvk9whKgTKc/xU=
MIME-Version: 1.0
Received: by 10.210.143.9 with SMTP id q9mr2723160ebd.85.1240323020098; Tue, 
	21 Apr 2009 07:10:20 -0700 (PDT)
In-Reply-To: <d77cedf30904210646v2ea71655ye83c8b57fecab761@mail.gmail.com>
References: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com>
	 <200904201100.39164.florian@openwrt.org>
	 <20090420.085929.-1089997132.imp@bsdimp.com>
	 <d77cedf30904202350g602c740dh26641f145677ddd5@mail.gmail.com>
	 <49EDC965.60507@paralogos.com>
	 <d77cedf30904210646v2ea71655ye83c8b57fecab761@mail.gmail.com>
Date:	Tue, 21 Apr 2009 16:10:20 +0200
X-Google-Sender-Auth: da02f7ad0db9bca4
Message-ID: <10f740e80904210710sdc9e5c2ic310e689ca6677b5@mail.gmail.com>
Subject: Re: in mips how to change the start address to the new second boot 
	loader ?
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	nagalakshmi veeramallu <lucky.veeramallu@gmail.com>
Cc:	"Kevin D. Kissell" <kevink@paralogos.com>,
	"M. Warner Losh" <imp@bsdimp.com>, florian@openwrt.org,
	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 21, 2009 at 15:46, nagalakshmi veeramallu
<lucky.veeramallu@gmail.com> wrote:
> hi,
>          --          if we set environmental variable “start” as “go
> new_address”, will it go directly to the new bootloader in the next
> power-on.
> what about using system environmental "start" ,can you tell me at which
> context after power on environmental variables come onto picture.

Environment variables are parsed by the boot loader, whose code resides at,
guess what, 0x1fc00000...

> On Tue, Apr 21, 2009 at 6:55 PM, Kevin D. Kissell <kevink@paralogos.com>
> wrote:
>>
>> nagalakshmi veeramallu wrote:
>>
>> -           Mips atlas board has jumper  which will redirect accesses from
>> “Bootcode” range to either “Monitor flash” (0x1e000000) or the upper 4MB of
>> “System flash” (0x1dc00000) based on jumper settings. if my kmc board have
>> some jumper like this, can I redirect the start address.
>>
>> Of course, what is really happening there is that the Atlas boot ROM has a
>> vector at 0x1fc00000 which reads the jumper and jumps to one address or the
>> other depending on the jumper setting. If you control what is in ROM at
>> 0x1fc00000 and you have a software-readable jumper on your KMC board, you
>> can do the same thing.
>>
>>           Regards,
>>
>>           Kevin K.
>>
>
>



-- 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
