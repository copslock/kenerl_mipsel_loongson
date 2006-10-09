Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 20:13:01 +0100 (BST)
Received: from web31506.mail.mud.yahoo.com ([68.142.198.135]:10098 "HELO
	web31506.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20039732AbWJITM7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 20:12:59 +0100
Received: (qmail 13895 invoked by uid 60001); 9 Oct 2006 19:12:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qJlMHlzL5eySTVMnY6tZANn2V5SSSAjyfPmPjyttluN41BzfQquaFkvsfBfQmUE+9VN3icQpKNpWSCdSMkn5YkRXjzBcC5kGphCeCy+qOaNZhkCQ7BmcEEDbIynDCeFA6ed9AUhLz96YIHYGM6SYchZRTdxvJ3TTkEftJ9wg/cc=  ;
Message-ID: <20061009191252.13893.qmail@web31506.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31506.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 12:12:52 PDT
Date:	Mon, 9 Oct 2006 12:12:52 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: CFE problem: starting secondary CPU.
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	girish <girishvg@gmail.com>, Kaz Kylheku <kaz@zeugmasystems.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20061009132540.GA4372@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

--- Ralf Baechle <ralf@linux-mips.org> wrote:
> The average firmware implementation contains alot of
> dark magic about
> hardware initialization.  Producing a decent
> replacement is not trivial.

Ok, does anyone here know if Voldemort is a good code
hacker? :)
 
(snip)
> How x86 or Linux centric is LinuxBIOS?  Makers of
> Linux devices want to
> support other operating systems as well.

LinuxBIOS is listed as supporting Linux (!), Plan 9
and Windows 2000. They don't support any of the *BSDs,
as there's apparently some BIOS calls in their
bootloaders and LinuxBIOS doesn't do BIOS calls. The
total intrusion into Linux is a 10-line hook and there
obviously can't even be that for Windows, so I think
most other OS' should be ok with it.

The supported motherboards include your usual x86
stuff (including Opterons, which I'm taking as meaning
it'll work on 64-bit systems) and PowerPC chips. The
FAQ also mentions the Alpha processor, but I didn't
see any examples amongst the listed vendors or
supported motherboards.

Jonathan

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
