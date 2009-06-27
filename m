Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2009 09:40:15 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.178]:52299 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492841AbZF0HkH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 Jun 2009 09:40:07 +0200
Received: by wa-out-1112.google.com with SMTP id n4so465774wag.0
        for <linux-mips@linux-mips.org>; Sat, 27 Jun 2009 00:35:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=e4rFtw/oFrPt3XkHOEPlsvfLHLu2hI7jPbi8seUM9w8=;
        b=hQfFxC6jmlspf9Qx1o/a76qHT5Bl1Sn3stMqITL+YJtIzXEUIRw/BUclf4KpAgp/TY
         1RmOh8e/AztQcC6JsLYFpmQVSw3ajT20lOFvijE1ivHF5mMQufMpHpTOMWfg9tN32nuu
         Crk5keI1mPSi2StBDi5ZMIHntjUPcdZCcePNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GE5/YT66ArkRXFRlxkyKwIVMkGdsEu2soZHiU9QKwrtjsCCPuKloslIvEvVM6/ksaM
         sKeBjh5nI4t1F8Qil8gfbhzGn4VVAXO4p9ozyh/gt4WrYSoiQ4/tDmQfJgEDdjgQd4BT
         s1wEIrtPvW9XZNEnNyI/HRLjgMOEJLfUXyw3A=
MIME-Version: 1.0
Received: by 10.114.135.16 with SMTP id i16mr1904976wad.3.1246088151307; Sat, 
	27 Jun 2009 00:35:51 -0700 (PDT)
In-Reply-To: <4A44E8B6.8010107@caviumnetworks.com>
References: <4f9abdc70906260030q3cefba63tb2fd30245a7015df@mail.gmail.com>
	 <4A44E8B6.8010107@caviumnetworks.com>
Date:	Sat, 27 Jun 2009 13:05:51 +0530
Message-ID: <4f9abdc70906270035g130ad3a8s520f494b84dbe11b@mail.gmail.com>
Subject: Re: linux porting - doubts
From:	joe seb <joe.seb8@gmail.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016364176819e1715046d4f8149
Return-Path: <joe.seb8@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe.seb8@gmail.com
Precedence: bulk
X-list: linux-mips

--0016364176819e1715046d4f8149
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I hadn't realized my memory can be mapped using add_memory_region.
Thank you for correcting me.

Regards,
Joe

On Fri, Jun 26, 2009 at 8:56 PM, David Daney <ddaney@caviumnetworks.com>wrote:

> joe seb wrote:
>
>> Hi,
>>
>> We are trying to port linux to our new platform based on MIPS32 24Kc.
>>
>> In our platform we have physical RAM of 256M mapped from 0x90000000
>> to 0xa0000000( KSEG0 - cached) and 0xb0000000 to 0xc0000000(KSEG1-
>> uncached).
>>
>> We made the following changes for our platform,
>>
>> CAC_BASE to  0x90000000 in spaces.h
>> KSEG0 to 0x90000000 and KSEG1 to 0xb0000000 in addrspace.h
>> CKSEG0 to 0x90000000 and CKSEG1 to 0xb0000000 in addrspace.h
>> loadaddr to 0x90000000 in the Makefile under arch/mips folder.
>>
>> Are these changes sufficient??
>> Is there any other platform port with such variations which we can refer
>> to
>> make sure about the changes made.
>>
>>
> That seems mostly wrong.
>
> The CAC_BASE, KSEG0, and CKSEG0 should probably be left unchanged.  You the
> load-y in arch/mips/Makefile for your target to the load address of the
> kernel.  Then when registering memory call  add_memory_region() only for the
> physical memory that you want the kernel to use.  In your case physical
> addresses from 0 to fffffff would seem to have no RAM, so you would do
> something like:
>
>  add_memory_region(0x10000000, 0x10000000, BOOT_MEM_RAM);
>
> David Daney
>
>

--0016364176819e1715046d4f8149
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I hadn&#39;t realized my memory can be mapped using add_memory_r=
egion.<br>Thank you for correcting me.<br><br>Regards,<br>Joe<br><br><div c=
lass=3D"gmail_quote">On Fri, Jun 26, 2009 at 8:56 PM, David Daney <span dir=
=3D"ltr">&lt;<a href=3D"mailto:ddaney@caviumnetworks.com">ddaney@caviumnetw=
orks.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">joe seb wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br>
<br>
We are trying to port linux to our new platform based on MIPS32 24Kc.<br>
<br>
In our platform we have physical RAM of 256M mapped from 0x90000000<br>
to 0xa0000000( KSEG0 - cached) and 0xb0000000 to 0xc0000000(KSEG1- uncached=
).<br>
<br>
We made the following changes for our platform,<br>
<br>
CAC_BASE to =A00x90000000 in spaces.h<br>
KSEG0 to 0x90000000 and KSEG1 to 0xb0000000 in addrspace.h<br>
CKSEG0 to 0x90000000 and CKSEG1 to 0xb0000000 in addrspace.h<br>
loadaddr to 0x90000000 in the Makefile under arch/mips folder.<br>
<br>
Are these changes sufficient??<br>
Is there any other platform port with such variations which we can refer to=
<br>
make sure about the changes made.<br>
<br>
</blockquote>
<br></div></div>
That seems mostly wrong.<br>
<br>
The CAC_BASE, KSEG0, and CKSEG0 should probably be left unchanged. =A0You t=
he load-y in arch/mips/Makefile for your target to the load address of the =
kernel. =A0Then when registering memory call =A0add_memory_region() only fo=
r the physical memory that you want the kernel to use. =A0In your case phys=
ical addresses from 0 to fffffff would seem to have no RAM, so you would do=
 something like:<br>

<br>
=A0add_memory_region(0x10000000, 0x10000000, BOOT_MEM_RAM);<br><font color=
=3D"#888888">
<br>
David Daney<br>
<br>
</font></blockquote></div><br>

--0016364176819e1715046d4f8149--
