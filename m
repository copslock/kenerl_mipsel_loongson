Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2007 01:32:54 +0100 (BST)
Received: from web53805.mail.re2.yahoo.com ([206.190.36.200]:15026 "HELO
	web53805.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20023099AbXDJAcw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Apr 2007 01:32:52 +0100
Received: (qmail 45686 invoked by uid 60001); 10 Apr 2007 00:31:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NUAg+sRncJRDBwv7gXLTunNYhCaci75i3uPq4j02NZZmo6rcDJFK0bY5vPBUv39bKREvTq3rkHn7HvBIxL9ehykFwp0V5m4vlubQZnkvWfEM/0bw7qIEg2qG0X/Yd9lA9BadtWh/tRJa8VbBx9l+5qPSg93M63gt9UJBLDiHY0w=  ;
Message-ID: <20070410003146.45684.qmail@web53805.mail.re2.yahoo.com>
X-YMail-OSG: BkxMcj0VM1nulVNbHLW.81E0Q7anLDL.hsM9Gp4dujAvrDAXX6fOm05GRpZ1nMMEJ8zfdqA6688D9Go6pTS9Ch74PgLRqisuZEzn5KSeIsMZZ8FObMASHBvSRsmtqA--
Received: from [76.192.205.82] by web53805.mail.re2.yahoo.com via HTTP; Mon, 09 Apr 2007 17:31:46 PDT
Date:	Mon, 9 Apr 2007 17:31:46 -0700 (PDT)
From:	h h <harsh512@yahoo.com>
Subject: Re: Describing Physical RAM Map to Linux
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2092484646-1176165106=:44285"
Content-Transfer-Encoding: 8bit
Return-Path: <harsh512@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harsh512@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-2092484646-1176165106=:44285
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit




On Sat, Apr 07, 2007 at 02:59:15PM -0700, h h wrote:

> I have a very basic question -- When describing physical memory to the kernel 
> in prom_init(), should we describe the physical memory region where kernel is 
> loaded or leave it out?  We are using add_memory_region() call to describe 
> physical memory to the kernel.  If we do describe the memory region where 
> kernel is loaded, how will kernel know not to use these pages for User 
> processes?

Ralf wrote:
The kernel does this automatically.

---

Sorry I don't quite understand -- What does kernel do 
automatically?  
How does kernel automatically know how much RAM is 
installed?

If you mean kernel automatically reserves the memory
it is loaded in, my question is where is this being 
done? I am expecting calls to alloc_bootmem or 
reserve_bootmem with addresses for text/data/stack
regions of kernel, but I don't see them.

Any pointers would be appreciated.


Thanks,



       
---------------------------------
Need Mail bonding?
Go to the Yahoo! Mail Q&A for great tips from Yahoo! Answers users.
--0-2092484646-1176165106=:44285
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<pre><br><br>On Sat, Apr 07, 2007 at 02:59:15PM -0700, h h wrote:<br><br><span style="font-family: mon;"><span style="font-style: italic;">&gt; </span></span><i>I have a very basic question -- When describing physical memory to the kernel </i><br><span style="font-family: mon;"><span style="font-style: italic;">&gt; </span></span><i>in </i><i>prom_init(), should we describe the physical memory region where kernel is </i><br>&gt;<i> loaded or leave it out?  We are using add_memory_region() call to describe </i><br>&gt;<i> physical memory to the kernel.  If we do describe the memory region where </i><br>&gt;<i> kernel is loaded, how will kernel know not to use these pages for User </i><br>&gt;<i> processes?</i><br><br>Ralf wrote:<br>The kernel does this automatically.<br><br>---<br><br>Sorry I don't quite understand -- What does kernel do <br>automatically?  <br>How does kernel automatically know how much RAM is <br>installed?<br><br>If you mean kernel automatically reserves
 the memory<br>it is loaded in, my question is where is this being <br>done? I am expecting calls to alloc_bootmem or <br>reserve_bootmem with addresses for text/data/stack<br>regions of kernel, but I don't see them.<br><br>Any pointers would be appreciated.<br><br><br>Thanks,<br><br></pre><p>&#32;
      <hr size=1>Need Mail bonding?<br>Go to the <a href="http://answers.yahoo.com/dir/index;_ylc=X3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx?link=ask&sid=396546091">Yahoo! Mail Q&A</a> for <a href="http://answers.yahoo.com/dir/index;_ylc=X3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx?link=ask&sid=396546091">great tips from Yahoo! Answers</a> users.
--0-2092484646-1176165106=:44285--
