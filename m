Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2006 08:19:42 +0200 (CEST)
Received: from nf-out-0910.google.com ([64.233.182.187]:65421 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133350AbWFAGTf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Jun 2006 08:19:35 +0200
Received: by nf-out-0910.google.com with SMTP id l36so376233nfa
        for <linux-mips@linux-mips.org>; Wed, 31 May 2006 23:19:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iT86CN9FTt8ZSUeEbX70Y+pQHsYbPlkYNTUlCv/A96E1SSahCsp11op/b0XXODk8NKUnGmpwRQ2N5XSKIbtXZzNKootrEWKpSYAcSc4dBTmBnpHC+4lEzA5nrmKadCTbXNipaZhFZV8SZH0Zzuw+RAAQ85xTkVxIjLqOOZjemnw=
Received: by 10.49.15.6 with SMTP id s6mr78309nfi;
        Wed, 31 May 2006 23:19:29 -0700 (PDT)
Received: by 10.66.241.4 with HTTP; Wed, 31 May 2006 23:19:25 -0700 (PDT)
Message-ID: <50c9a2250605312319v7480f2el36d9c0a052c85d5f@mail.gmail.com>
Date:	Thu, 1 Jun 2006 14:19:29 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: BFD: Warning: Writing section `.text' to huge (ie negative) file offset 0xa1ffff10
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i have write a code to link at 0xa2000000(uncached address)
but when link i get the error as
"BFD: Warning: Writing section `.text' to huge (ie negative) file
offset 0xa1ffff10.
BFD: Warning: Writing section `.data' to huge (ie negative) file
offset 0xa200b050.
BFD: Warning: Writing section `.reginfo' to huge (ie negative) file
offset 0xa200c980.
mipsel-linux-objcopy: /root/project/brec_flash/release/brec_flash.bin:
File truncated
make: *** [brec_flash] Error 1"

my link.xn as follow:

OUTPUT_ARCH(mips)
ENTRY(brec_flash_entry)
SECTIONS
{
.text 0xa2000000 :
	{
     release/entry.o (.text)
	
	            release/*(.text)
	}
	
.data :
	{
	            release/*(.data)
	}
	
.sbss :
  	{
  	            release/*(.sbss)
 	            release/*(.scommon)
 	}

.bss :
 	{
 	            release/*(.bss)
  	            release/*(COMMON)
 	 }

 }



thanks for any hints

Best Regards

zhuzhenhua
