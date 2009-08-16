Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Aug 2009 18:21:09 +0200 (CEST)
Received: from mail-yw0-f176.google.com ([209.85.211.176]:64844 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492222AbZHPQVC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 16 Aug 2009 18:21:02 +0200
Received: by ywh6 with SMTP id 6so3486261ywh.0
        for <linux-mips@linux-mips.org>; Sun, 16 Aug 2009 09:20:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=l+d+wDrfBUO4qjJjW6WTuhJINl/e0ndWnys6XtjAx5E=;
        b=B92PwIcwA/iHfB7tG0eJO+5WcW2F6BUJ8oCOGGkTpmWxykREDkfRXogt+g/OQWd1+J
         iY0kgahlm9TLcavW3Q+nJvbHXP7YnenbvCdK80qzTN6zXGIgZH0sVuAWpO3H01pLVXwf
         YHOCHfcMfW3aLMz+LeWBUgYwvJNHfx1n1JEzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=wzyc55R0WQ7U59X7EyfTFKpZaasUqU8X3EpoXrPwtu7yXeA14yGMO+pjZKvkh3oaLt
         XhI5U96fUD5d7lAQCb+kxfS/D1q4D2U3Y/GNUXREy0jMLclS47RIJG2LXpYagK0+Cu68
         PnwfG/l4cLigpXeAcTj8cOyC/20MFTrheGxdM=
MIME-Version: 1.0
Received: by 10.90.103.10 with SMTP id a10mr2199337agc.2.1250439656254; Sun, 
	16 Aug 2009 09:20:56 -0700 (PDT)
Date:	Mon, 17 Aug 2009 00:20:56 +0800
Message-ID: <e997b7420908160920y14d8ea95v5fb25eba67e7b6db@mail.gmail.com>
Subject: kexec on mips failed
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	nschichan@freebox.fr
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8BIT
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,Nicolas,


I've got some problem with kexec on mips32...


in your code for kexec on mips32, there is a relocate_new_kernel function .


In the end of this function , it jump to kexec_start_address by   'j  s1'



Because I  changed the kexec-tools code  ,in the hope that, it
simplely passed the new kernel segment  data  into the old kernel.(so

I didn't  pass  the command-line segment in, in my code, there is just
one segment , segment[0] = kernel_data).


So  I need to change register s1 to the new kernel entry address, and
jump to new kernel directly.



In my vmlinux,  the entry is 0x802b0000£¬so I let image->start =
0x2b0000£¬and invoke relocate_new_kernel.


However, whether I changed kexec_start_address to 0x802b0000 or
0x2b0000 , the  'j  s1'  seemed taking no effect?


(I wrote 88 to address0xa1230000  before 'j  s1' , it succedd .I also
wrote 78 to address 0xa1230000 in the beginning

of head.S of the new kernel , but failed. And I reset the board to
uboot mode, used 'md 0x802b0400' to display the new kernel

in ram, it is identical  to the objdump content of the vmlinux.  So I
guess, this problem lays in the failing of 'j  0x802b0000'

or 'j   0x2b0000'.    I don't know why 'j s1' failed , any suggestions
about this ?  Thank you very much.

regads,

Wilbur
