Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49DrPM27436
	for linux-mips-outgoing; Wed, 9 May 2001 06:53:25 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49DrPF27433
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 06:53:25 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id IAA25596;
	Wed, 9 May 2001 08:53:22 -0500
Message-ID: <3AF94EFE.88B7B1BD@cotw.com>
Date: Wed, 09 May 2001 09:06:54 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre17-idepci i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Jaeger <aj@suse.de>
CC: linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
References: <20010505144708.A12575@paradigm.rfc822.org>
		<20010507163210.B2381@bacchus.dhis.org>
		<20010508202518.A13476@paradigm.rfc822.org>
		<20010508214313.A12528@bacchus.dhis.org>
		<20010509095955.A8392@sonycom.com>
		<20010509104635.D12267@paradigm.rfc822.org>
		<3AF934AE.38AB0089@cotw.com> <hoeltyemh0.fsf@gee.suse.de>
		<3AF93D3F.5E57070@cotw.com> <hopudid73g.fsf@gee.suse.de>
		<3AF94D3C.98A4E8@cotw.com> <hor8xybpjc.fsf@gee.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Andreas Jaeger wrote:
> 
> So the one-liner you mailed should be all that has to be added?
> 
Yes and....

> > For the correct ld emulation, I assume you mean make changes in glibc
> > to check for the proper target 'elf[32|64]trad[little|big]mips'?
> 
> That's what I mean,
> 
And these changes. If you want to commit the one-liner fine...but I will
need some time today to make the fix to glibc to check for the proper
emulation target. You can either wait and I can include the one-liner
with the emulation check patch or commit it.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
