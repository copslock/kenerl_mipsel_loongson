Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 07:59:17 +0000 (GMT)
Received: from mail-bw0-f161.google.com ([209.85.218.161]:48346 "EHLO
	mail-bw0-f161.google.com") by ftp.linux-mips.org with ESMTP
	id S20808810AbZCEH7I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2009 07:59:08 +0000
Received: by bwz5 with SMTP id 5so3781463bwz.0
        for <multiple recipients>; Wed, 04 Mar 2009 23:59:02 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=VQAygljJbtVx3hMfoU/6vYDpSB57WJsQ+3kO+QPHR54=;
        b=ZL/u/fwcdTcyuaHxh8S5cNB9VmW+PyglOw1w+OaKiTZbqvJL3Q6+esgNhIY28ZCizS
         AkWmuC7M6Ov0aZXXlOugYs5+ftaMTiQigc5rv6emVg3rKbirERkPh/XFKmBANw4+iyG6
         k34k9wfmJU+AiK2f+3oEqdc6B78RmkPRinnKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=e9yMpXTX1ncDllyfVCbJsHx1Kb1vThDt/LLbuJhbswWWLWrZH+1sbFau3toem+u+zd
         fqrLvANRQcogpnD2InJ9aC2sk9kBcP2sdKneRTjNjmneL2X3zi5bzWsUDLUm90VkfJM3
         F9mWIJKfBri+44U9IVQEZT1QQQHvWwpCDNeCM=
Received: by 10.180.245.20 with SMTP id s20mr275234bkh.184.1236239942778;
        Wed, 04 Mar 2009 23:59:02 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id 10sm4081054bwz.24.2009.03.04.23.58.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Mar 2009 23:59:01 -0800 (PST)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	David Daney <ddaney@caviumnetworks.com>
Subject: MIPS RI/XI & trampolines [was:- [PATCH, RFC] MIPS: Implement the getcontext API ]
Date:	Thu, 5 Mar 2009 08:58:31 +0100
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
Cc:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <FF038EB85946AA46B18DFEE6E6F8A289BE0B68@xmb-rtp-218.amer.cisco.com> <49AF01E8.80705@caviumnetworks.com>
In-Reply-To: <49AF01E8.80705@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200903050858.32232.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Wednesday 04 March 2009 23:34:16 David Daney wrote:
> David VomLehn (dvomlehn) wrote:
> >> -----Original Message-----
> >> Sent: Wednesday, March 04, 2009 7:44 AM
> >> From: [...] On Behalf Of Ralf Baechle
> >>
> >> On Wed, Mar 04, 2009 at 09:19:28AM +0100, Brian Foster wrote:
> >>> On Tuesday 03 March 2009 17:56:25 David Daney wrote:
> >>>>[ ... ]
> >>>> When (and if) we move the sigreturn trampoline to a vdso we should be
> >>>> able to maintain the ABI.
> >>> it's more a matter of "when" rather than "if".
> >>> there is still an intention here to use XI (we
> >>> have SmartMIPS), which requires not using the
> >>> signal (or FP) trampoline on the stack.
> >>>[ ... ]
> >> We generally want to get rid of stack trampolines.
> >> Trampolines require cacheflushing which especially
> >> on SMP systems can be a rather expensive operation.
> > 
> > If I understand this correctly, using a vdso would allow a stack without
> > execute permission on those processors that differentiate between read
> > and execute permission. This defeats attaches that use buffer overrun to
> > write code to be executed onto the stack, a nice thing for more secure
> > systems.

 correct, albeit there are at least two caveats;
 one is, as David points out, (pointer-to) GCC nested
 functions;  the other is the MIPS FP trampoline.

> With one caveat, software other than the Linux kernel depends on an
> executable stack (GCC's nested functions for example).  All users of the
> executable stack would have to modified before you could universally
> make the switch.
> 
> That said, we do have RI/XI working well in our kernel (for non-stack
> memory), so it is something we are interested in pursuing.

David,

 I am Very Interested in this.  we also want RI/XI,
 at least for for userland (and, very importantly,
 including the stack), but haven't yet time to deal
 with the issue.  (our platform is the 4KSd, which
 has SmartMIPS (and thus has RI/XI)).

 is what you have at linux-mips.org someplace?

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
