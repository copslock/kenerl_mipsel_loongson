Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4GAS3nC016614
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 16 May 2002 03:28:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4GAS3U6016613
	for linux-mips-outgoing; Thu, 16 May 2002 03:28:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from brahma.intotoind.com ([202.56.196.162])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4GARpnC016610
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 03:27:54 -0700
Received: from localhost (rajeshbv@localhost)
	by brahma.intotoind.com (8.9.3/8.8.7) with ESMTP id PAA01553;
	Thu, 16 May 2002 15:52:57 +0530
X-Authentication-Warning: brahma.intotoind.com: rajeshbv owned process doing -bs
Date: Thu, 16 May 2002 15:52:57 +0530 (IST)
From: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
X-Sender: rajeshbv@brahma.intotoind.com
To: "Tommy S. Christensen" <tch@avanticore.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@oss.sgi.com
Subject: Re: RAMDISK problem on 79s334A board.
In-Reply-To: <3CE37364.945C40A7@avanticore.com>
Message-ID: <Pine.LNX.4.10.10205161551090.1409-100000@brahma.intotoind.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Tommy,

I am using 2.4.3 code and in that linux/mm/vmallo.c contains the following
code which is slightly different from the patch you gave.

        } while (address && (address < end));
        unlock_kernel();
        flush_tlb_all();
        return ret;

Can you please suggest how to modify this.

Regards,
--Rajesh

On Thu, 16 May 2002, Tommy S. Christensen wrote:

> Alan Cox wrote:
> > 
> > > But the same module is working fine and kernel is also fine if i use NFS
> > > and insert the module.
> > > Any further info ?
> > 
> > Not really. The fact it works with NFS and not ramdisk may simply be that
> > in one case it corrupts memory that is used, and the other it corrupts
> > memory that isnt
> 
> Using a ramdisk increases the pressure on memory. So the difference could
> be that one case hits the cache aliasing problem, the other doesn't.
> 
> Try this patch and see if it helps.
> 
>  -Tommy
> 
> 
> 
> Index: mm/vmalloc.c
> ===================================================================
> RCS file: /cvs/linux/mm/vmalloc.c,v
> retrieving revision 1.28
> retrieving revision 1.28.2.1
> diff -u -r1.28 -r1.28.2.1
> --- mm/vmalloc.c        2001/10/19 01:25:06     1.28
> +++ mm/vmalloc.c        2001/12/28 21:06:01     1.28.2.1
> @@ -163,6 +163,7 @@
>                 ret = 0;
>         } while (address && (address < end));
>         spin_unlock(&init_mm.page_table_lock);
> +       flush_cache_all();
>         return ret;
>  }
> 
