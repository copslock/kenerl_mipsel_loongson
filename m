Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2006 09:15:25 +0100 (BST)
Received: from web51104.mail.yahoo.com ([206.190.38.146]:55146 "HELO
	web51104.mail.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133560AbWDYIPP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Apr 2006 09:15:15 +0100
Received: (qmail 27836 invoked by uid 60001); 25 Apr 2006 08:28:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bJmQ5IsXlr0cX/cKn01CH1h0Rre/W46u1YQu2pfhCTnZ3lchw3JdjZdCpLVnyyMw9XOouZAeaXzjV1NpG1LlXR4HmGIRuODNdxd2g9ky07ibaMKcrECefZdAmzBa08bE+tcYdcSwc2fZsNtZj5ZMbNqcam/TW0DaBWQULUfWdgc=  ;
Message-ID: <20060425082819.27834.qmail@web51104.mail.yahoo.com>
Received: from [217.37.158.157] by web51104.mail.yahoo.com via HTTP; Tue, 25 Apr 2006 01:28:19 PDT
Date:	Tue, 25 Apr 2006 01:28:19 -0700 (PDT)
From:	"D.J. Barrow" <barrow_dj@yahoo.com>
Reply-To: dj_barrow@ariasoft.ie
Subject: mips kernel modules are very big, any suggestions on reducing their size
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <barrow_dj@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: barrow_dj@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,
For every external symbol in a module.
Because of the -mlong-calls gcc option you have
2 relocation entries am R_MIPS_HI_16 R_MIPS_LO_16 entry.
A string table entry for the symbol & three instructions
for each jump or call. We can eliminate the string table
entry by making as many functions as possible static
but this means changing investigating every source file
of which there are around 100.

It would save a fortune in space if we were allowed
link into the kernel but the module is from broadcom
& we are not allowed to do this.

If anyone has any good suggestions I would be very greatful.

D.J. Barrow Linux kernel developer
eMail: dj_barrow@ariasoft.ie
Work:+44-1274-538401 
Home: +353-22-47196.
Mobile (IRL) +353-(0)86 1715438

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
