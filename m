Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49BucU21503
	for linux-mips-outgoing; Wed, 9 May 2001 04:56:38 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49BubF21500
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 04:56:37 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id GAA25018;
	Wed, 9 May 2001 06:51:15 -0500
Message-ID: <3AF93260.A9C63FB3@cotw.com>
Date: Wed, 09 May 2001 07:04:48 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre17-idepci i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: machine types for MIPS in ELF file
References: <3AF843F7.72BC47F0@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:
> 
> The e_machine field in ELF file standard defines two values for MIPS:
> 
> 8       - MIPS RS3000 BE
> 10      - MIPS RS4000 BE
> 
> Naturally the question is: what about LE binaries?  And what about other
> CPUs?  Is there any effort to clean up this thing?
> 
> All the tools that I know of are using 8, pretty much for all CPUs and both
> endians.  No real harm has been observed, but it causes some anonying "invalid
> byte order" complains if you do "file" on a MIPS LE binary.  Of course, it
> will also invariably reports "R3000" cpu as well.
> 
This has bothered me as well. I would like to see a few machines added
at least something like R5000, R8000, R10000 along with the proper ISA
value being stored in the e_flags field. I would be more than happy to
help make the changes as it is something that IMHO needs to be fixed.

As far as the latest ABI specs go, here are 2 different links for the
same documents. Ralf and I went digging for these a few weeks back.

    http://www.sco.com/partners/developer/devspecs/
    http://www.linuxbase.org/spec/refspecs/

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
