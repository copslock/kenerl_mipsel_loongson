Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2004 21:25:42 +0100 (BST)
Received: from web50810.mail.yahoo.com ([IPv6:::ffff:206.190.38.253]:35217
	"HELO web50810.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225241AbUHEUZh>; Thu, 5 Aug 2004 21:25:37 +0100
Message-ID: <20040805202530.36026.qmail@web50810.mail.yahoo.com>
Received: from [65.204.143.11] by web50810.mail.yahoo.com via HTTP; Thu, 05 Aug 2004 13:25:30 PDT
Date: Thu, 5 Aug 2004 13:25:30 -0700 (PDT)
From: G H <giles67@yahoo.com>
Subject: Re: do_ri failure in cache flushing routines
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
In-Reply-To: <20040805111133.B28337@mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-729533103-1091737530=:34229"
Return-Path: <giles67@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giles67@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-729533103-1091737530=:34229
Content-Type: text/plain; charset=us-ascii

I was also thinking that maybe it could be related to the MIPS32 instruction cache flushing routine, so I tried applying the patch Ralf posted. The system still functioned OK for me, but one other in my group had their board lock up hard ( no oops produced ), and when I asked Ralf if that patch was ready for applying to CVS, he said it needed to be reworked before doing that. As a result we didn't follow up too closely on that avenue of investigation.
 
So basically what I am concluding from the responses so far , is that do_ri should NEVER occur in blast_icache32() and for it to do so, it could be either a hardware problem, or possibly the MIPS32 icache flushing problem.
Anyone agree / disagree ?
 
Jun Sun <jsun@mvista.com> wrote:


One possibility _could_ be the "instruction flushing itself" problem on
MIPS32. However, as far as I know au1x00 CPUs don't suffer from this problem.
Anybody knows for sure?


You could try to use the two phase cache flushing (such as the one used
by tx47xx and also see an earlier related discussion thread) and see if
the problem goes away.


		
---------------------------------
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
--0-729533103-1091737530=:34229
Content-Type: text/html; charset=us-ascii

<DIV>I was also thinking that maybe it could be related to the MIPS32 instruction cache flushing routine, so I tried applying the patch Ralf posted. The system still functioned OK for me, but one other in my group had their board lock up hard ( no oops produced ), and when I asked Ralf if that patch was ready for applying to CVS, he said it needed to be reworked before doing that. As a result we didn't follow up too closely on that avenue of investigation.</DIV>
<DIV>&nbsp;</DIV>
<DIV>So basically what I am concluding from the responses so far , is that do_ri should NEVER occur in blast_icache32() and for it to do so, it could be either a hardware problem, or possibly the MIPS32 icache flushing problem.</DIV>
<DIV>Anyone agree / disagree ?</DIV>
<DIV>&nbsp;</DIV>
<DIV><B><I>Jun Sun &lt;jsun@mvista.com&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">
<P><BR>One possibility _could_ be the "instruction flushing itself" problem on<BR>MIPS32. However, as far as I know au1x00 CPUs don't suffer from this problem.<BR>Anybody knows for sure?</P>
<P><BR>You could try to use the two phase cache flushing (such as the one used<BR>by tx47xx and also see an earlier related discussion thread) and see if<BR>the problem goes away.<BR></P></BLOCKQUOTE><p>
		<hr size=1>Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/mail_us/taglines/security/*http://promotions.yahoo.com/new_mail/static/protection.html">Yahoo! Mail</a> - You care about security. So do we.
--0-729533103-1091737530=:34229--
