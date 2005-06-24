Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 09:47:50 +0100 (BST)
Received: from web25808.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.193]:3723
	"HELO web25808.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225508AbVFXIrc>; Fri, 24 Jun 2005 09:47:32 +0100
Received: (qmail 82754 invoked by uid 60001); 24 Jun 2005 08:46:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0MG9KGfGwJlN1GmHX20FXb5nsT6fRyYs9HXyAkT37zY8j3eM/E5JKrbF6gC7M7tYkw+aHLTYtTQwX+pSTbajK1R3JQA+CLLHZqiwMwAn8pyXFRKBkA/x4ecTS94+p4j/iVnm2SVn8zkltUM22rL2Lws5JJXXBSSWb79kmBXZ/2o=  ;
Message-ID: <20050624084633.82752.qmail@web25808.mail.ukl.yahoo.com>
Received: from [217.167.142.149] by web25808.mail.ukl.yahoo.com via HTTP; Fri, 24 Jun 2005 10:46:33 CEST
Date:	Fri, 24 Jun 2005 10:46:33 +0200 (CEST)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: which 2.6 kernel can be run on db1550?
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:

>moreau francis wrote:
>
>>HEAD doens't compile 
>
>
>Yep, that happens when there is active development going on. Nonetheless, I'd 
>stay with that one and try to fix what is broken - in my experience these are 
>only small oversights, not real trouble. Also, for such things it pays to 
>sometimes get on #linux-mips an irc.freenode.net.
>

I found this in "include/linux/compiler-gcc2.h". 
"""
/* GCC 2.95.x/2.96 recognize __va_copy, but not va_copy. Actually later GCC's
 * define both va_copy and __va_copy, but the latter may go away, so limit this
 * to this header */
#define va_copy                       __va_copy
"""

That's not correct seems my gcc (2.96) defines va_copy.

Another thing in "arch/mips/kernel/ptrace.c" line 273:
"""
                case DSP_BASE ... DSP_BASE + 5:
                        if (!cpu_has_dsp) {
                                ret = -EIO;
                                break;
                        }
                        dspreg_t *dregs = __get_dsp_regs(child);
                        dregs[addr - DSP_BASE] = data;
                        break;
"""

dregs variable is declared in an incorrect place (no opening block here)...

Hope it helps.

        Francis



	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
