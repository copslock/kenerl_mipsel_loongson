Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2JMwj609584
	for linux-mips-outgoing; Tue, 19 Mar 2002 14:58:45 -0800
Received: from granite.he.net (granite.he.net [216.218.226.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2JMwS909535
	for <linux-mips@oss.sgi.com>; Tue, 19 Mar 2002 14:58:28 -0800
Received: from w2k30g (209-142-39-228.stk.inreach.net [209.142.39.228]) by granite.he.net (8.8.6/8.8.2) with SMTP id OAA10270 for <linux-mips@oss.sgi.com>; Tue, 19 Mar 2002 14:59:56 -0800
Message-ID: <017701c1cf99$a7d9a890$0b01a8c0@w2k30g>
From: "David Christensen" <dpchrist@holgerdanske.com>
To: <linux-mips@oss.sgi.com>
Subject: Fw: hello
Date: Tue, 19 Mar 2002 14:55:22 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

linux-mips@oss.sgi.com:

Thank you all for your replies.  :-)


Hartvig Ekner <hartvige@mips.com> wrote:
>> 2.  What is the preferred host OS...
> We use Linux/x86 for kernel compiles,

Which Linux distribution does MIPS use?  Since I'm going to be working
on an Atlas board using software from MIPS, I would like to match things
up exactly.

As an aside, is anybody using a VMware virtual machine for their
development host?

> and native compile for apps.

OK  that sounds like a safe bet.

>> 3.  What is the preferred toolchain...
> This is what we use for cross Kernel compiles (toolchain from oss):
>
> /home/hartvige> gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)

Hmmm.  That looks like a native i386 compiler.  I'm surprised its not
something like "mips-elf-gcc".

I'll assume the cross-compile toolchain was built per
http://oss.sgi.com/mips/mips-howto.html section 10.

>> 4.  Is MIPS Linux self-hosted?
> Yes. Even without workstations, you could use MIPS or Algo development
> boards for self-hosted development (which is what we do - primarily
> Malta boards).

Good.  :-)

>> 5.  Can you do native development on MIPS Linux?
> Yes.

Good.  :-)

>> 6.  Does MIPS Linux support sound (oss or alsa) on any platform?
>>     Does it support sound on MIPS Atlas?
> Yes. Plug in a Creative SB card, based on the Ensoniq chip and
> enable the es1371.c in the kernel compile. Works both LE & BE, and
> with apps like madplay (mp3) and mplayer (mpeg4).

Great!  :-)


Florian Lohoff <flo@rfc822.org> wrote:
>> 1.  Is there a reason why SourceForge isn't being used for the MIPS
>>     Linux project?
> The Linux-mips project is much older than sourceforge and looking at
> the history of hyped venture capital companys does not really give a
> good feeling about using sourceforge. Personally spoken i dont like
> sourceforge - For most cases its just too bloated and working for ISPs
> its not a problem to get some public accesible ftp/web/cvs space.

OK  I've used SourceForge as a software consumer and liked it.  I just
received their approval for an GPL'd Perl utility I wrote ("dirdiff").

>> 4.  Is MIPS Linux self-hosted?
> Definitly

Good. :-)

>> 5.  Can you do native development on MIPS Linux?
> Yep - The Debian autobuilder run native on little and big endian.

Hmmm.  Do you mean GNU autoconf running natively on MIPS, or something
running on a Debian x86 host, or something else?

>> 6.  Does MIPS Linux support sound (oss or alsa) on any platform?
Does
>>     it support sound on MIPS Atlas?
> Somme rumors about Indy/Indigo2 HAL support have been heard.

OK

> The problem with some sourceforge trees and the split up information
> is that like you already experienced is a real problem for Linux-mips
> as there is no "source of the only wisdom". I dont like that tree-
> forking etc. Either build your stuff clean - ready for inclusion -
> or just drop the tree under the table as a big bad ugly hack.

OK


Adrian Schroeter <adrian@suse.de> wrote:
>>> 6.  Does MIPS Linux support sound (oss or alsa) on any platform?
>>>     Does it support sound on MIPS Atlas?
>> Some rumors about Indy/Indigo2 HAL support have been heard.
> oss works for me here on Indy/Indigo2. The arts drivers seems to be
> too outdated atm.

OK


Leo Przybylski <leop@engr.arizona.edu> wrote:
> Well, all Linux/MIPS stuff on on oss.sgi.com is maintained largely by
> Ralf Baechle who is also contributor to numerous Linux/MIPS projects
> on sourceforge. As far as I know he is also a huge part of the
> sourceforge Linux/MIPS. You may have noticed that Bradley D. LaRonde
> is also a huge contributor.
>
> You have probably guessed that all the projects on sourceforge
> regarding linux mips are related by the maintainers and contributors.
> Most of the code is being contributed to sourceforge, oss.sgi.com,
> debian, redhat and so on. When everyone has their own toolchains,
> roots and kernels it's hard to keep them in their own repositories.
> oss.sgi.com has tried largely to do this though which is why it is a
> good place to start. The ftp site carries debian and redhat binaries,
> patches, etc... There's also the linux-mips kernel located in the
> oss.sgi.com CVS repository.
>
> As for why it is working to keep most of the resources in oss.sgi.com
> contrary to sourceforge, I don't really have an answer to that. Hope
> this helps.

Thanks for the background.  Clearly, linux-mips has much history behind
it.


David
