Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4GCVbnC020174
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 16 May 2002 05:31:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4GCVbsL020173
	for linux-mips-outgoing; Thu, 16 May 2002 05:31:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4GCVXnC020169
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 05:31:33 -0700
Received: from mail.avanticore.com (firewall.i-data.com [195.24.22.194]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA05956
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 05:31:48 -0700 (PDT)
	mail_from (tch@avanticore.com)
Received: from avanticore.com ([172.17.159.1]) by mail.avanticore.com with Microsoft SMTPSVC(5.0.2195.2966);
	 Thu, 16 May 2002 14:28:43 +0200
Message-ID: <3CE3A675.486BC12A@avanticore.com>
Date: Thu, 16 May 2002 14:30:45 +0200
From: "Tommy S. Christensen" <tch@avanticore.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
CC: linux-mips@oss.sgi.com
Subject: Re: RAMDISK problem on 79s334A board.
References: <Pine.LNX.4.10.10205161551090.1409-100000@brahma.intotoind.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2002 12:28:44.0055 (UTC) FILETIME=[37FB8A70:01C1FCD5]
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Venkata Rajesh Bikkina wrote:
> 
> Hi Tommy,
> 
> I am using 2.4.3 code and in that linux/mm/vmallo.c contains the following
> code which is slightly different from the patch you gave.
> 
>         } while (address && (address < end));
>         unlock_kernel();
>         flush_tlb_all();
>         return ret;
> 
> Can you please suggest how to modify this.
> 
> Regards,
> --Rajesh
> 

2.4.3 is quite old, so upgrading the kernel would clearly be a good idea.

Anyway, if you want to try this fix then you should remove the call to
flush_cache_all() at the top of vmalloc_area_pages() and change the line
flush_tlb_all() to flush_cache_all().

 -Tommy
