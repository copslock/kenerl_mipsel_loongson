Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4G8qfnC015701
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 16 May 2002 01:52:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4G8qfSM015700
	for linux-mips-outgoing; Thu, 16 May 2002 01:52:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4G8qbnC015697
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 01:52:37 -0700
Received: from mail.avanticore.com (firewall.i-data.com [195.24.22.194]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA04773
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 01:52:58 -0700 (PDT)
	mail_from (tch@avanticore.com)
Received: from avanticore.com ([172.17.159.1]) by mail.avanticore.com with Microsoft SMTPSVC(5.0.2195.2966);
	 Thu, 16 May 2002 10:50:51 +0200
Message-ID: <3CE37364.945C40A7@avanticore.com>
Date: Thu, 16 May 2002 10:52:52 +0200
From: "Tommy S. Christensen" <tch@avanticore.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@oss.sgi.com
Subject: Re: RAMDISK problem on 79s334A board.
References: <E177ypv-0001up-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2002 08:50:51.0278 (UTC) FILETIME=[C80012E0:01C1FCB6]
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Alan Cox wrote:
> 
> > But the same module is working fine and kernel is also fine if i use NFS
> > and insert the module.
> > Any further info ?
> 
> Not really. The fact it works with NFS and not ramdisk may simply be that
> in one case it corrupts memory that is used, and the other it corrupts
> memory that isnt

Using a ramdisk increases the pressure on memory. So the difference could
be that one case hits the cache aliasing problem, the other doesn't.

Try this patch and see if it helps.

 -Tommy



Index: mm/vmalloc.c
===================================================================
RCS file: /cvs/linux/mm/vmalloc.c,v
retrieving revision 1.28
retrieving revision 1.28.2.1
diff -u -r1.28 -r1.28.2.1
--- mm/vmalloc.c        2001/10/19 01:25:06     1.28
+++ mm/vmalloc.c        2001/12/28 21:06:01     1.28.2.1
@@ -163,6 +163,7 @@
                ret = 0;
        } while (address && (address < end));
        spin_unlock(&init_mm.page_table_lock);
+       flush_cache_all();
        return ret;
 }
