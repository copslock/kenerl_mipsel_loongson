Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 18:31:44 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.186]:58903 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022854AbXHVRbm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Aug 2007 18:31:42 +0100
Received: by mu-out-0910.google.com with SMTP id w1so240558mue
        for <linux-mips@linux-mips.org>; Wed, 22 Aug 2007 10:31:24 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J+//BiW1D9/jCzIqG4icz0zgvbTxsoDawk+AuS3pI5W0hFRlhOmQ1INtnMgrYSYDYPocKXqpYrJ7CTiRcQsChTIOb41TKC+9Z2TnrEw4n4Mg71lze3G7evUAKxApoB4gezta79P52xnJG648uLkGOKEjC9WmFIWfQn0KF482fU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W05EPtUDfLe4EGe5+OzLa96tdmiVph+oMmffPrbc65fNzfFo1pkFbFEQ1ESGnhuSrDGdOUR3oHDxcoECpyMVQ8Badw5stEIP0Wrisz/yZrp3I6oAGMun2fuWIGmUV8/Gx28ejiNgrYVTJo6DgxTAoTFPEZ5lUzY3lp80gHJxaYg=
Received: by 10.82.178.11 with SMTP id a11mr893136buf.1187803882860;
        Wed, 22 Aug 2007 10:31:22 -0700 (PDT)
Received: by 10.82.190.1 with HTTP; Wed, 22 Aug 2007 10:31:22 -0700 (PDT)
Message-ID: <c58a7a270708221031g3fba98d5u8507c2aafd4e16b4@mail.gmail.com>
Date:	Wed, 22 Aug 2007 18:31:22 +0100
From:	"Alex Gonzalez" <langabe@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Bus error after successful mmap of physical address
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am sure there is a basic reason why this is not working but I just
can't see it.

I am booting with mem=512MB and trying to access a memory region at
0xC0000000 mapped by a fixed TLB entry.

My driver does,

vma->vm_flags = vma->vm_flags | VM_IO | VM_RESERVED ;
vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot) ;

	// Map the whole physically contiguous area in one piece
	if( (ret  = io_remap_pfn_range(vma , vma->vm_start, vma->vm_pgoff ,
vma->vm_end - vma->vm_start , vma->vm_page_prot)) < 0 )
    return ret;
	return 0

And my user space app does:

// open device
	vadr = mmap( NULL , 1024*1024 ,
PROT_WRITE|PROT_READ,MAP_NORESERVE|MAP_SHARED,device,0xC0000000);
	if(vadr == MAP_FAILED)
	{
		perror("mmap failed.\n");
		exit(-1);
	}


That goes OK, but then if I try to read or write from vadr I get a "Bus error".

Isn't that the correct way to map a physical address region to user
space? I just need to make sure that this is the case before starting
to debug the issue.

Thank a lot,
Alex
