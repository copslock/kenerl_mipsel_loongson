Received:  by oss.sgi.com id <S553763AbQJMA6J>;
	Thu, 12 Oct 2000 17:58:09 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:47375 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553721AbQJMA5w>;
	Thu, 12 Oct 2000 17:57:52 -0700
Received: (qmail 7795 invoked from network); 13 Oct 2000 00:57:45 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 13 Oct 2000 00:57:45 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: modutils bug? 'if' clause executes incorrectly 
In-reply-to: Your message of "Fri, 13 Oct 2000 02:23:50 +0200."
             <20001013022350.J21634@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 13 Oct 2000 11:57:44 +1100
Message-ID: <10267.971398664@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 13 Oct 2000 02:23:50 +0200, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>On Thu, Oct 12, 2000 at 01:25:31PM +1100, Keith Owens wrote:
>> By the time insmod has finished with the module, the rest is a binary
>> blob.  No ELF headers, no symbols, all the sections run together with a
>> struct module at the start.  I can dump that easily enough but I
>> question how much use it would be.  Outputing anything more complicated
>> such as ELF headers and symbols would be a significant addition to
>> insmod.
>
>The blob is actually already ok and just what I wanted.  You can easily talk
>objdump into disassembling that easily.  All that is required in addition
>is the base address of the blob as the argument of the --adjust-vma option.

I will add insmod option -O to save the binary object to a file.
  insmod -m -O binary module
will save the binary blob, -m already gives you the section and symbol
map for the final binary object.
