Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4DIXQnC006993
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 13 May 2002 11:33:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4DIXQL9006992
	for linux-mips-outgoing; Mon, 13 May 2002 11:33:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sentinel.sanera.net (ns1.sanera.net [208.253.254.10])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4DIXInC006989
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 11:33:18 -0700
Received: from icarus.sanera.net (icarus [192.168.254.11])
	by sentinel.sanera.net (8.11.2/8.11.2) with ESMTP id g4DIXW006620;
	Mon, 13 May 2002 11:33:32 -0700
Received: from exceed1.sanera.net (exceed1.sanera.net [172.16.2.31])
	by icarus.sanera.net (8.11.6/8.11.6) with SMTP id g4DIXRT21466;
	Mon, 13 May 2002 11:33:27 -0700
Message-Id: <200205131833.g4DIXRT21466@icarus.sanera.net>
Date: Mon, 13 May 2002 11:33:27 -0700 (PDT)
From: Krishna Kondaka <krishna@Sanera.net>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
Subject: Re: Is this a /proc or kernel bug? (more info...)
To: flo@rfc822.org
Cc: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: jKWVtFz27WkEbVsnIesOKA==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.2 SunOS 5.8 sun4u sparc 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for the reply florian!

I think I was able to fix this problem by writing the code differently.
Initially I copied some code from the existing proc_read routines but they
are assuming a maximum of page size, in this case 4K.

I have modified the my proc read code as below, and it seem to work fine!

static int
mydriver_proc_read(char *page, char **start, off_t off, int count, int *eof
void *d)
{
	uint32_t pos, len, i;
	
	len = MIN(count, (SIZE-off));
	pos = (off & (PAGE_SIZE-1));

	if (len > 0) {
		for (i = 0; i < len; i++)
			page[pos+i] = ' ' + i % 64;
		*start = page + (off & (PAGE_SIZE-1));
	} else {
		len = 0;
		*eof = 0;
	}
}
	
I am assuming that (off & (PAGE_SIZE-1)) + count <= PAGE_SIZE, which seems
to be the case always during my testing.


Krishna

>X-Authentication-Warning: oss.sgi.com: mail owned process doing -bs
>X-Authentication-Warning: oss.sgi.com: majordomo set sender to 
owner-linux-mips@oss.sgi.com using -f
>Date: Sun, 12 May 2002 15:36:56 +0200
>From: Florian Lohoff <flo@rfc822.org>
>To: Krishna Kondaka <krishna@Sanera.net>
>Cc: linux-mips@oss.sgi.com
>Subject: Re: Is this a /proc or kernel bug? (more info...)
>Mime-Version: 1.0
>Content-Disposition: inline
>User-Agent: Mutt/1.3.28i
>
>On Wed, May 08, 2002 at 08:28:32PM -0700, Krishna Kondaka wrote:
>> The above function works fine as long as the SIZE is lessthan 4K. If SIZE is
>> greater than 4K then some times I see the following kernel panic when
>> I try to do "cat /proc/<myfilename>"
>> 
>> Unhandled kernel unaligned access in unaligned.c:emulate_load_store_insn, 
line 
>> 373:
>> $0 : 00000000 10009f00 8f20802c 48494a4b
>> $4 : 8f320988 00000001 00000000 00000116
>
>IIRC i386 has the same problem with reading more then a single page from 
>/proc.
>
>Retrieving more information should probably be a device driver with
>a char or block interface.
>
>Flo
>-- 
>Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>                        Heisenberg may have been here.
