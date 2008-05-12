Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 03:19:07 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.189]:22355 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20030229AbYELCTE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 03:19:04 +0100
Received: by ti-out-0910.google.com with SMTP id i7so730560tid.20
        for <linux-mips@linux-mips.org>; Sun, 11 May 2008 19:18:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=7jQlHvHMFGW91el3y6cFu4sVsXexSrXt5C4jqAgQU+E=;
        b=KsTrIS4LEzhHrbszitWgeBJmPSEwTErDhPLdy2zsZINoYrl+wUfTHJgGOvliuh7Q8TBLclkze1gAfKa0+NyTOvom3NyaDA5VhapWIUj8Dg5IQjB+HPrrDdMS795ttEtDFpmRvmdkwQ0xyu98UZCbOIYKG+qSWJGhQgiH8YkUn4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=UYmElo1XX9MN4dwLKiQQW5LG9/K5IDLEEGvL6L7iWwNefu46Dy/htsjP3wn/r1lUWfmWjf2KKRoBe8UnuYztiWX/SIjCOw0+VDnDFVbqvbHnMsTrcNGTpwDQUzm/pSfLU7UpwWGJC7fIY4Ddd2h/1EWSHhpVTXaHqYZ5W2qU6qM=
Received: by 10.110.57.6 with SMTP id f6mr722355tia.35.1210558707305;
        Sun, 11 May 2008 19:18:27 -0700 (PDT)
Received: by 10.110.42.3 with HTTP; Sun, 11 May 2008 19:18:27 -0700 (PDT)
Message-ID: <50c9a2250805111918r16913139obfc2982220636b3@mail.gmail.com>
Date:	Mon, 12 May 2008 10:18:27 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: is remap_pfn_range should align to 2(n) * (page size) ?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20080509095605.GB14450@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_470_27076401.1210558707284"
References: <50c9a2250805082354x1edc1ecar89dcc3378b3bbe75@mail.gmail.com>
	 <20080509095605.GB14450@linux-mips.org>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_470_27076401.1210558707284
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 5/9/08, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Fri, May 09, 2008 at 02:54:29PM +0800, zhuzhenhua wrote:
>
> >            i have a sensor driver want to malloc 2.xM SDRAM to capture
> > data(using DMA),  so i used  remap_pfn_range to malloc 3M.
> > But in /proc/meminfo, it showes free memory reduce 4M. i also check the
> > /proc/buddyinfo, it seemes too.
> > (i am looking inside kernel code, but not get clear at now).
> >
> >  is remap_pfn_range should align to  2(n) * (page size) ?
>
>
> This has nothing to do with remap_pfn_range but with the power of two
> sized buckets used by the global free page pool.  Any allocation with
> get_free_pages will be rounded up to the next power of two.  If that's a
> real concern for you you could allocate a 4MB page then split the page
> into a 2MB and two 1MB pages and free the 1MB page again.
>
>
>   Ralf


thanks for your reply , i see in get_frree_pages and free_pages there is a
get_order(size).
but i don't understand  " allocate a 4MB page then split the page
into a 2MB and two 1MB pages and free the 1MB page again."
is there any function to split it?

thanks for any hints

Best Regards


zzh

------=_Part_470_27076401.1210558707284
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 5/9/08, <b class="gmail_sendername">Ralf Baechle</b> &lt;<a href="mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, May 09, 2008 at 02:54:29PM +0800, zhuzhenhua wrote:<br> <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i
have a sensor driver want to malloc 2.xM SDRAM to capture<br> &gt; data(using DMA),&nbsp;&nbsp;so i used&nbsp;&nbsp;remap_pfn_range to malloc 3M.<br> &gt; But in /proc/meminfo, it showes free memory reduce 4M. i also check the<br> &gt; /proc/buddyinfo, it seemes too.<br>
 &gt; (i am looking inside kernel code, but not get clear at now).<br> &gt;<br> &gt;&nbsp;&nbsp;is remap_pfn_range should align to&nbsp;&nbsp;2(n) * (page size) ?<br> <br> <br>This has nothing to do with remap_pfn_range but with the power of two<br>
 sized buckets used by the global free page pool.&nbsp;&nbsp;Any allocation with<br> get_free_pages will be rounded up to the next power of two.&nbsp;&nbsp;If that&#39;s a<br> real concern for you you could allocate a 4MB page then split the page<br>
 into a 2MB and two 1MB pages and free the 1MB page again.<br> <br><br>&nbsp;&nbsp;Ralf</blockquote><div><br>
thanks for your reply , i see in get_frree_pages and free_pages there is a get_order(size).<br>
but i don&#39;t understand&nbsp; &quot; allocate a 4MB page then split the page<br>
 into a 2MB and two 1MB pages and free the 1MB page again.&quot;<br>
is there any function to split it? <br>
<br>
thanks for any hints<br>
<br>
Best Regards<br>
<br>
<br>
zzh<br>
<br>
<br>
<br>
&nbsp;</div><br><div><br>
&nbsp;</div><br></div><br>

------=_Part_470_27076401.1210558707284--
