Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 15:36:08 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:36267 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23834983AbYKVPfx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Nov 2008 15:35:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mAMFZhSd016888;
	Sat, 22 Nov 2008 15:35:43 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mAMFZgtb016887;
	Sat, 22 Nov 2008 15:35:42 GMT
Date:	Sat, 22 Nov 2008 15:35:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Chad Reese <kreese@caviumnetworks.com>,
	linux-mips@linux-mips.org
Subject: Re: Is there no way to shared code with Linux and other OSes?
Message-ID: <20081122153542.GB31703@linux-mips.org>
References: <4927C34F.4000201@caviumnetworks.com> <4927D6E0.4020009@paralogos.com> <Pine.LNX.4.64.0811221109330.29539@anakin> <4927E2A4.5000702@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4927E2A4.5000702@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 22, 2008 at 04:44:52AM -0600, Kevin D. Kissell wrote:

>>   
>>> [This should be good for some useless weekend flaming.]
>>>     
>>
>> Yeah! ;-)

With the oil price down so far we gotta make some good use of that ;-)

> That's a better argument than the one in the HTML version of  
> Documentation/CodingStyle.txt that I had bookmarked (which was what I  
> cited).  Interestingly, if I look at the *current* Linux  
> Documentation/CodingStyle.txt for 2.6.28-rc6, the blanket interdiction  
> of typedefs is no longer there!  Things *have* evolved, as I said they'd  
> have to, to recognize 5 (a good Illuminati number) cases where typedefs  
> are permitted.  Superficially, based on Chad's description (I admit that  
> I haven't been reviewing his patches) the Cavium case would seem to fall  
> into the first category. Is the MIPS Linux community now some kind of  
> ultra-orthodox sub-sect of the Linux cult? ;o)

There was never a blanket interdiction of typedefs though it may seem to
and unfortunately scripts/checkpatch.pl also bitches about every typedef,
no matter what.  It was rather a restriction to only using typedefs for
simple types such as char, int or pointers but not on structs - otherwise
the definitions for u32 etc. would not have made it in.  In a 2002 OLS
paper giving a bit of a rationale for the Linux coding standard Greg KH
writes:

[...]
typedef is evil

typedef should not be used in naming any of your structures. Almost all main
kernel structures do not have a typedef to shorten their usage. This
includes the following:

	struct inode
	struct dentry
	struct file
	struct buffer_head
	struct user
	struct task_struct

Using typedef tries to hide the real type of a variable. There have been
records of some kernel code using typedefs nested up to 4 layers deep,
preventing the programmer from telling what type of variable they are really
using. This can easily cause very large structures to be accidentally
declared on the stack, or to be returned from functions if the programmer
does not realize the size of the structure.  typedef can also be used as a
crutch to keep from typing long structure denitions. If this is the case,
the structure names should be made shorter, according to the above listed
naming rules.  Never define a typedef to just signify a pointer to a
structure, as in the following example:

	typedef struct foo
	{
		int bar;
		int baz;
	} foo t, *pfoo_t;

This again hides the true type of the variable, and is using the name of
the variable type to define what is is (see the comment about Hungarian
notation previously.

Some examples of where typedef is badly used are in the include/raid/md*.h
files where every structure has a typedef assigned to it, and in the
drivers/acpi/include/*.h files, where a lot of the structures do not even
have a name assigned to them, only a typedef.

The only place that using typedef is acceptable, is in declaring function
prototypes. These can be difcult to type out every time, so declaring a
typedef for these is nice to do. An example of this is the bh_end_io_t
typedef which is used as a parameter in the init buffer() call. This is
defined in include/fs.h as:

	typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);

[...]

The full paper is available at http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_paper/codingstyle.ps

  Ralf
