Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 19:13:18 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:53862 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23840646AbYKVTNJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Nov 2008 19:13:09 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4928599d0000>; Sat, 22 Nov 2008 14:12:29 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 22 Nov 2008 11:08:10 -0800
Received: from [192.168.111.195] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 22 Nov 2008 11:08:09 -0800
Message-ID: <49285895.6020303@caviumnetworks.com>
Date:	Sat, 22 Nov 2008 11:08:05 -0800
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.17) Gecko/20080829 Iceape/1.1.12 (Debian-1.1.12-1)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	"Kevin D. Kissell" <kevink@paralogos.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips@linux-mips.org
Subject: Re: Is there no way to shared code with Linux and other OSes?
References: <4927C34F.4000201@caviumnetworks.com> <4927D6E0.4020009@paralogos.com> <Pine.LNX.4.64.0811221109330.29539@anakin> <4927E2A4.5000702@paralogos.com> <20081122153542.GB31703@linux-mips.org>
In-Reply-To: <20081122153542.GB31703@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2008 19:08:10.0147 (UTC) FILETIME=[A8DB7730:01C94CD5]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

I appreciate the info about the typedefs, but I didn't really mean to
signal them out. They just happened to be an example I picked. The
fundamental issue is that we have a large number of files written using
a fairly common corporate coding standard (4 space indents, no tabs,
javadoc comments) that is used by a number of OSes. We generate our API
documentation from it using doxygen, so the comments at least attempt to
have useful info in them. In order to use this code in the kernel, we're
having to basically run it through the evil indent program and strip
quite a bit of stuff out. Obviously indent will make a mess of some
stuff, so lots of hand editing is needed. The end result is code that
has diverged from the original in such a way that diffs are basically
impossible.

We're already having issues with bugs between the different versions and
the kernel submit stuff has just started. Maybe the only solution is two
divergent code bases, but it just feels like the gun is pointed at my
foot and cocked. I really don't want to pull the trigger knowing what is
about to happen.

Obviously I don't target these comments at true Linux drivers. The CF
libata driver is obviously a Linux specific driver and should follow all
Linux standards. Code for bootloader communication and networks setup is
completely OS agnostic, so sharing it between systems makes sense.

Chad

Ralf Baechle wrote:
> On Sat, Nov 22, 2008 at 04:44:52AM -0600, Kevin D. Kissell wrote:
> 
>>>   
>>>> [This should be good for some useless weekend flaming.]
>>>>     
>>> Yeah! ;-)
> 
> With the oil price down so far we gotta make some good use of that ;-)
> 
>> That's a better argument than the one in the HTML version of  
>> Documentation/CodingStyle.txt that I had bookmarked (which was what I  
>> cited).  Interestingly, if I look at the *current* Linux  
>> Documentation/CodingStyle.txt for 2.6.28-rc6, the blanket interdiction  
>> of typedefs is no longer there!  Things *have* evolved, as I said they'd  
>> have to, to recognize 5 (a good Illuminati number) cases where typedefs  
>> are permitted.  Superficially, based on Chad's description (I admit that  
>> I haven't been reviewing his patches) the Cavium case would seem to fall  
>> into the first category. Is the MIPS Linux community now some kind of  
>> ultra-orthodox sub-sect of the Linux cult? ;o)
> 
> There was never a blanket interdiction of typedefs though it may seem to
> and unfortunately scripts/checkpatch.pl also bitches about every typedef,
> no matter what.  It was rather a restriction to only using typedefs for
> simple types such as char, int or pointers but not on structs - otherwise
> the definitions for u32 etc. would not have made it in.  In a 2002 OLS
> paper giving a bit of a rationale for the Linux coding standard Greg KH
> writes:
> 
> [...]
> typedef is evil
> 
> typedef should not be used in naming any of your structures. Almost all main
> kernel structures do not have a typedef to shorten their usage. This
> includes the following:
> 
> 	struct inode
> 	struct dentry
> 	struct file
> 	struct buffer_head
> 	struct user
> 	struct task_struct
> 
> Using typedef tries to hide the real type of a variable. There have been
> records of some kernel code using typedefs nested up to 4 layers deep,
> preventing the programmer from telling what type of variable they are really
> using. This can easily cause very large structures to be accidentally
> declared on the stack, or to be returned from functions if the programmer
> does not realize the size of the structure.  typedef can also be used as a
> crutch to keep from typing long structure denitions. If this is the case,
> the structure names should be made shorter, according to the above listed
> naming rules.  Never define a typedef to just signify a pointer to a
> structure, as in the following example:
> 
> 	typedef struct foo
> 	{
> 		int bar;
> 		int baz;
> 	} foo t, *pfoo_t;
> 
> This again hides the true type of the variable, and is using the name of
> the variable type to define what is is (see the comment about Hungarian
> notation previously.
> 
> Some examples of where typedef is badly used are in the include/raid/md*.h
> files where every structure has a typedef assigned to it, and in the
> drivers/acpi/include/*.h files, where a lot of the structures do not even
> have a name assigned to them, only a typedef.
> 
> The only place that using typedef is acceptable, is in declaring function
> prototypes. These can be difcult to type out every time, so declaring a
> typedef for these is nice to do. An example of this is the bh_end_io_t
> typedef which is used as a parameter in the init buffer() call. This is
> defined in include/fs.h as:
> 
> 	typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
> 
> [...]
> 
> The full paper is available at http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_paper/codingstyle.ps
> 
>   Ralf

-- 

Chad Reese <kreese@caviumnetworks.com>
Cavium Networks
Phone: 650 - 623 - 7038
Cell: 321 - 438 - 7753
