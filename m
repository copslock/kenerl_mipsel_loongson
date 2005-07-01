Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 09:00:41 +0100 (BST)
Received: from web25802.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.187]:24144
	"HELO web25802.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8226122AbVGAIAW>; Fri, 1 Jul 2005 09:00:22 +0100
Received: (qmail 54752 invoked by uid 60001); 1 Jul 2005 08:00:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JC/Xwq1cJIQExT1x80z3wyl1kJYQSrmCJhr2/JvbHt3UDf5LvJL63ZK27PwCEWOcMuV8hxSzCmg/iMLMoKS3ldMZyVX0YA6o5sac1iWfQBck7cQXcrahD0Bf6GTwpkUXWOokjzSMTJ76yDUDYPgD58f4Y/t5B1evIODmuHH4jVw=  ;
Message-ID: <20050701080003.54738.qmail@web25802.mail.ukl.yahoo.com>
Received: from [217.167.142.149] by web25802.mail.ukl.yahoo.com via HTTP; Fri, 01 Jul 2005 10:00:02 CEST
Date:	Fri, 1 Jul 2005 10:00:02 +0200 (CEST)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: I built a mipsel-linux toolchain, but it doesn't work
To:	David Daney <ddaney@avtrex.com>
Cc:	zhan rongkai <zhanrk@gmail.com>, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

David Daney wrote:

> zhan rongkai wrote:
>
>> Hi folks,
>>
>> At last night, I built a mipsel-linux cross-toolchain according to the
>> following steps:
>>
>> 1) The list of GNU Toolchain source packages
>> =======================================================
>>
>> * binutils: binutils-2.16.1.tar.gz
>> *      gcc: gcc-3.4.4.tar.gz
>> *    Linux: Linux-2.6.12.tar.bz2 (from www.kernel.org)
>> *   uClibc: uClibc-0.9.27.tar.gz
>> *      gdb: gdb-6.3.tar.gz
>>
>
> IIRC gcc does not currently work out-of-the-box with uClibc.  If you are
> using uClibc, your best bet is probably to use the Buildroot system that 
> can be found at the uClibc web site.
>

Could you develop please ? What kind of config/hack does Buildroot to be able
to use GCC with uClibc ?

thanks

              Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
