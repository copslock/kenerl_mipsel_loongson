Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAS5Vwf02618
	for linux-mips-outgoing; Tue, 27 Nov 2001 21:31:58 -0800
Received: from sentinel.sanera.net (ns1.sanera.net [208.253.254.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAS5Vho02614;
	Tue, 27 Nov 2001 21:31:43 -0800
Received: from icarus.sanera.net (icarus [192.168.254.11])
	by sentinel.sanera.net (8.11.2/8.11.2) with ESMTP id fAS4Vbu18295;
	Tue, 27 Nov 2001 20:31:37 -0800
Received: from exceed2.sanera.net (exceed2.sanera.net [172.16.2.39])
	by icarus.sanera.net (8.11.6/8.11.6) with ESMTP id fAS4VWD07063;
	Tue, 27 Nov 2001 20:31:32 -0800
Received: from exceed2.sanera.net (exceed2.sanera.net [172.16.2.39])
	by exceed2.sanera.net (8.9.3+Sun/8.9.3) with SMTP id UAA22140;
	Tue, 27 Nov 2001 20:31:32 -0800 (PST)
Message-Id: <200111280431.UAA22140@exceed2.sanera.net>
Date: Tue, 27 Nov 2001 20:31:32 -0800 (PST)
From: Krishna Kondaka <krishna@Sanera.net>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
Subject: Re: Memory leaks in SMP MIPS linux 2.4.9?
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: pAX61yYTCRKByEvqLoCbZQ==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.2 SunOS 5.8 sun4u sparc 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for the quick reply ralf!

Sorry for not mentioning that I did already patch my 2.4.9 with the fix that
you mentioned. Even then the MemFree is continuously going down.


>
>On Tue, Nov 27, 2001 at 05:09:00PM -0800, Krishna Kondaka wrote:
>
>> I suspect that there are some memory leaks in the SMP MIPS linux 2.4.9.
>> I would like to know if any one found the root cause and fixed them.
>
>See patch below for fix.
>
>> 	I just ran the script for 3 hours are here is the diff between
>> 	the out put of /proc/meminfo and /proc/slabinfo before and
>> 	after the test run ( lines with "<" are before the test and
>> 	lines with ">" are after the test)
>
>(Try diff -u which generates much more human readable output.)
>
>> 	When I did some investigation, it looked like d_lookup() is
>> 	not finding /proc/meminfo and /proc/slabinfo in the dcache and
>> 	it is doing d_alloc() to add these to the cache every time
>> 	cat /proc/meminfo or cat /proc/slabinfo is done. This looked odd
>> 	and I ran the same script on x86 based linux (running 2.4.2) and
>> 	I did not see MemFree (or any other caches) changing after the
>> 	test was run for an hour. I am not sure how this is architecture
>> 	dependent.
>
>These caches essentially keep growing until you run out of memory which
>is when they'll be freed.

	Yeah! But there is no need for them to grow because I am accessing
	the same file names again and again and hence they should be
	available in the cache after the first time. d_alloc()s are not
	not being done when referencing /lib/libc.so.6 second time but
	they are being done when referencing /proc/meminfo or /proc/slabinfo.
	The behavior is different because "/proc" is a mount point and
	"/lib" is not. But I still feel that there is no need to do d_alloc()
	for repeatedly when /proc/meminfo is already in the cache(I have printed
	the entire dcache entries and it shows that /proc/meminfo is in
	the dcache).
	
Thanks
Krishna

>

>  Ralf
>
>--- linux.orig/include/asm-mips/mmu_context.h.orig	Wed Nov 28 14:45:19 2001
>+++ linux/include/asm-mips/mmu_context.h	Wed Nov 28 14:47:37 2001
>@@ -109,7 +109,10 @@
>  */
> extern inline void destroy_context(struct mm_struct *mm)
> {
>-	/* Nothing to do.  */
>+#ifdef CONFIG_SMP
>+	if (mm->context)
>+		kfree((void *)mm->context);
>+#endif
> }
> 
> /*
