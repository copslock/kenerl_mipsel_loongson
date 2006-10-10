Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 19:12:03 +0100 (BST)
Received: from web31501.mail.mud.yahoo.com ([68.142.198.130]:8815 "HELO
	web31501.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20039800AbWJJSL7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 19:11:59 +0100
Received: (qmail 59512 invoked by uid 60001); 10 Oct 2006 18:11:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xzMIvgqeQYuGTgVcCDR9s6rd6i6edQiDY0F20jHpwToqbCOwtZsm3+gV7wwsvIPBra+tpdZ36kYQ6MyzmIZa7NWnNOGvSKAShvSgy4o+lAK+DU34fenG9yMih2EA/0m4UZ5xDDu52uxv65QcNFOHe1RP+WEj4u90MjXk2xLg+NM=  ;
Message-ID: <20061010181148.59510.qmail@web31501.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31501.mail.mud.yahoo.com via HTTP; Tue, 10 Oct 2006 11:11:48 PDT
Date:	Tue, 10 Oct 2006 11:11:48 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Memory freeing at boot time on SB1
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

Since updating to a more recent version of the git
repository, the patches published here that fixed the
memory freeing bug on the SB1 (Broadcom 1250) no
longer apply. A quick round of compiling, however,
shows that the problem that the patch fixed still
remains.

(As best as I recall, the problem was the switch from
some SB1-specific operations to generic ones.)

Does anyone have an updated memory free fix?

Jonathan

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
