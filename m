Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 18:45:15 +0100 (BST)
Received: from web40909.mail.yahoo.com ([IPv6:::ffff:66.218.78.206]:54434 "HELO
	web40909.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225273AbVDGRpB>; Thu, 7 Apr 2005 18:45:01 +0100
Received: (qmail 77211 invoked by uid 60001); 7 Apr 2005 17:44:54 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=NB3KsAKgKp4H1Dio2l6xaJt7OmqL+O8OCq14EgKJwgXcA/GxfWVHW1v4FrK3dHOd43nYfHmdEjd9nTgTRO84eOgzNV/ppEk+VycJXQvuzgji1ZFPHf/mgBqsJ08HXsM3ohUKNUuK1cnOgsYKPXvFEwfzB2YLqKAvAOzP6sb9kvw=  ;
Message-ID: <20050407174454.77209.qmail@web40909.mail.yahoo.com>
Received: from [65.205.244.66] by web40909.mail.yahoo.com via HTTP; Thu, 07 Apr 2005 10:44:54 PDT
Date:	Thu, 7 Apr 2005 10:44:54 -0700 (PDT)
From:	Brian Kuschak <bkuschak@yahoo.com>
Subject: gdb backtrace with core files
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <bkuschak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bkuschak@yahoo.com
Precedence: bulk
X-list: linux-mips

Is anyone succesfully using gdb for mipsel to debug
core dumps?  If so, can you share your secrets for
success?  I tried various recent versions (6.3,
6.1.1), but backtrace never works right, even though
the stack pointer appears to be valid.  gdb-5.3
partially works, but not completely.  

Forcing gdb to use a specific stack pointer and PC
(frame <sp> <pc>) doesn't seem to help either.  

Using linux 2.4.25 and gcc 3.3.3.

Regards,
Brian 




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
