Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2008 18:20:28 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:37283 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S23406719AbYKHSUZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Nov 2008 18:20:25 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 94EDE4002A;
	Sat,  8 Nov 2008 19:20:19 +0100 (CET)
Received: from [192.168.10.105] (c-5fbbe555.035-105-73746f38.cust.bredbandsbolaget.se [85.229.187.95])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 68EEF4001B;
	Sat,  8 Nov 2008 19:20:19 +0100 (CET)
Cc:	Kumba <kumba@gentoo.org>, gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Message-Id: <BC4F8B38-68DD-4E72-AA0D-928A379813A9@27m.se>
From:	Markus Gothe <markus.gothe@27m.se>
To:	Richard Sandiford <rdsandiford@googlemail.com>
In-Reply-To: <8763mypnhf.fsf@firetop.home>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-12-900597536"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
Date:	Sat, 8 Nov 2008 19:20:16 +0100
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org> <87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org> <8763mypnhf.fsf@firetop.home>
X-Pgp-Agent: GPGMail d53 (v53, Leopard)
X-Mailer: Apple Mail (2.929.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-12-900597536
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable

For what it's worth:

R10K should be able to compile with -mips4

On SGI-systems I think they deprecated all the R3K and earlier systems =20=

with IRIX 5.3 IIRC.

My old SGI Indigo (yeah, the original Indigo) R4K still runs fine with =20=

IRIX 6.5.22 and -mips3/n32-binaries last time I checked.

If in doubt ask on http://www.nekochan.net

//Markus

On 8 Nov 2008, at 10:37, Richard Sandiford wrote:

> Kumba <kumba@gentoo.org> writes:
>> Richard Sandiford wrote:
>>> Agreed, but that's just as true of option 1.  Each option is as =20
>>> correct
>>> as the other.  It's just a question of whether we need the =20
>>> combination:
>>>
>>>  -mips1 -mllsc -mfix-r10000
>>>
>>> to be accepted, or whether we can treat it as a compile-time error.
>>
>> Hmm, which do you think makes sense?  =46rom a usage perspective, =
most
>> developers are working in the MIPS32/MIPS64 ISA stuff.  In Gentoo, =20=

>> the
>> mips port mostly supports SGI systems, mostly anything with a MIPS-IV
>> capable processor (haven't decided on MIPS-III's fate just yet).
>> Debian I know has switched off of MIPS-I being the default for their
>> binaries, and I think is MIPS-II now.  In all these cases, the target
>> OS is usually Linux, although I know there are some Irix folks still
>> out there, plus the *BSDs all got their own ports.
>>
>> But I guess the question I'm pondering, is just how rare would it be
>> for someone to actually need a MIPS-I binary with ll/sc and
>> branch-likely fixes to run on something like an R10000?  Rare enough
>> to justify denying them that particular command argument combination,
>> and thus taking Option #1?  Or go the extra mile for Option #2?  I
>> don't know if that's my call to really make, since I lack the
>> statistical data to know who would be affected, and in what ways
>> (i.e., do they have alternative methods, such as MIPS-II, etc..).
>
> I'm not sure I have the statistical knowledge either.  I've tended
> to work in embedded environments where -march=3D<my cpu> is almost =20
> always
> the right option to use.  But like Maciej, I suspect it isn't worth
> supporting the combination.  So my preference is for option #1.
>
> You make a convincing case that the combination isn't useful for =20
> current
> Linux distributions.  And it isn't useful for IRIX 6 either: the o32
> system libraries are -mips2 rather than -mips1, and both GCC and
> MIPSpro default to -mips2 for o32.
>
> Also, I believe the glibc patch doesn't cope with -mips1 -mllsc =20
> either.
> Is that right?  If so, that's another reason not to worry about it
> for GCC.
>
> I don't have a strong opinion though.
>
>>> If you do go for option 2, you then have to decide whether to insert
>>> 28 nops after every LL/SC loop, or whether you try to do some =20
>>> analysis
>>> to avoid unnecessary nops.  The natural place for this analysis =20
>>> would
>>> be mips_avoid_hazard.
>>
>> Hmm, just looking at this out of curiosity to get an idea of what I =20=

>> might have
>> to tackle, but this particular sequence looks like the key:
>>
>>   /* Work out how many nops are needed.  Note that we only care about
>>      registers that are explicitly mentioned in the instruction's =20
>> pattern.
>>      It doesn't matter that calls use the argument registers or =20
>> that they
>>      clobber hi and lo.  */
>>   if (*hilo_delay < 2 && reg_set_p (lo_reg, pattern))
>>     nops =3D 2 - *hilo_delay;
>>   else if (*delayed_reg !=3D 0 && reg_referenced_p (*delayed_reg, =20
>> pattern))
>>     nops =3D 1;
>>   else
>>     nops =3D 0;
>>
>> I'd have to do some reading around the code to get an understanding =20=

>> of
>> how this function works and is called, but I'm taking a guess that
>> it's just an extra 'else if ... nops =3D 28 ...' for the simple =20
>> approach
>> (more complex if one were to try actual analysis).  Ot at minimum,
>> another entire if block, since this does look like it's specifically
>> for HI/LO checks.
>
> It's a bit more complicated than that.  The current code takes =20
> advantage
> of a nice property: that a gap of two instructions will avoid all the
> hazards that we currently handle.  So if we come across a branch,
> we only ever need to look at the branch and its delay slot; we never
> need to look at the target of a branch.  For the R10000 errata,
> you would either:
>
>  (1) need to do proper global (inter-block) analaysis, which is
>      a fair bit of new code; or
>
>  (2) conservatively assume that the target of a branch might be a
>      __sync_*() operation.
>
> Also, the "nops =3D" part of the current code inserts "#nop" rather =
than
> "nop" for ".set reorder" functions, because the assembler is supposed
> to avoid the hazards in that case.  Unless you make GAS do the same
> for this errata, you would need to:
>
>  (1) insert a real nop instead of a hazard_nop; and
>
>  (2) treat any asm as a potential atomic operation.
>
>>> If you go for option 1, you could replace things like:
>>>
>>>  "\tbeq\t%@,%.,1b\n"				\
>>>  "\tnop\n"					\
>>>
>>> with:
>>>
>>>  "\tbeq%?\t%@,%.,1b\n"				\
>>>  "\tnop\n"					\
>>
>> Looks simple enough.  I found the block explaining what the %?
>> parameter does.  Is that in any actual documentation aside from a
>> comment block in mips.c?  I'm only looking at the 4.3.2 Internals
>> Manual, cause I don't know if 4.4.x Internals is online yet.  Wasn't
>> sure if that was addressed from a documentation standpoint (or =20
>> whether
>> it's something that even needs to be listed online).
>
> The internals manual intentionally doesn't cover things like this.
> It's for target-independent stuff, not for internal details about
> each port.  So the mips.c comment _is_ the documentation.
>
>>> and make the .md insn do:
>>>
>>>  mips_branch_likely =3D TARGET_FIX_R10000;
>>
>> Can this go anywhere in sync.md (i.e., at the top in a proper place),
>> or does it need to go before any call to the macro templates?
>
> mips_branch_likely only applies to the _current_ insn, so it needs
> to go before any call the macro templates.  Please use a helper
> function such as:
>
> const char *
> mips_output_sync_insn (const char *template)
> {
>  mips_branch_likely =3D TARGET_FIX_R10000;
>  return template;
> }
>
>>> But something nattier is needed for MIPS_SYNC_NEW_OP and =20
>>> MIPS_SYNC_NEW_NAND,
>>> where the branch delay slot is not a nop.  In this case, we need =20
>>> to replace
>>> things like:
>>>
>>>  "\tbeq\t%@,%.,1b\n"				\
>>>  "\t" INSN "\t%0,%0,%2\n"			\
>>>
>>> with:
>>>
>>>  "\tbeql\t%@,%.,1b\n"				\
>>>  "\tnop\n"					\
>>>  "\t" INSN "\t%0,%0,%2\n"			\
>>
>> Looking at what %# and %/ do, Maybe a new punctuation character =20
>> that simply
>> dumps out a nop instead if mips_branch_likely is true?  I.e.:
>>
>>     case '~':
>>       if (mips_branch_likely)
>>         fputs ("\n\tnop", file);
>>       break;
>>
>> And:
>>
>>     "\tbeq%?\t%@,%.,1b%~\n"				\
>>     "\t" INSN "\t%0,%0,%2\n"			\
>>
>> '~' seems to be one of the last unused characters on my keyboard.
>> Seems like a good fit.
>
> Yeah, looks good.  I'm a bit worried about running of % characters,
> but like I say, we could always replace the templates with individual
> output_asm_insns at some point in the future.
>
> Richard
>

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com




--Apple-Mail-12-900597536
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkkV2GEACgkQ6I0XmJx2NrwqrwCdH320D1fAKgjSRWZdtP2W1jJP
LaYAoM4GIKrcUBVkQwqPTU2SdI2DH/Oi
=erbf
-----END PGP SIGNATURE-----

--Apple-Mail-12-900597536--
