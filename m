Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 09:44:28 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:57281 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038560AbWI1Io1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 09:44:27 +0100
Received: by nf-out-0910.google.com with SMTP id l23so687361nfc
        for <linux-mips@linux-mips.org>; Thu, 28 Sep 2006 01:44:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=cDPhIQg8p8jbtr00J8EhhnwNXOdlGzzmBpbd697z96ojr11Sm1HUxBQIG0pdcOdlg4RIyklwahLdw1ZqMSMwwJlgmPPpUBG2T37HkwcFjkLez29CO6E8mmzeJHTXa6TcfmP9tfPM1edfZhe56WxRiJ1bJ9sLoi3x7GLM+r1hV8U=
Received: by 10.49.92.18 with SMTP id u18mr3471170nfl;
        Thu, 28 Sep 2006 01:44:26 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id l38sm5181363nfc.2006.09.28.01.44.24;
        Thu, 28 Sep 2006 01:44:25 -0700 (PDT)
Message-ID: <451B8B9C.4000803@innova-card.com>
Date:	Thu, 28 Sep 2006 10:45:16 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Jonathan Day <imipak@yahoo.com>
CC:	Peter Popov <ppopov@embeddedalley.com>,
	Franck <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: How to work with Linux-Mips ?
References: <20060927031800.87246.qmail@web31506.mail.mud.yahoo.com>
In-Reply-To: <20060927031800.87246.qmail@web31506.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi

Jonathan Day wrote:
> Whilst I agree entirely, I think we need to put a
> little more perspective on this. The Linux kernel is
> big. Very, very big. By my estimate, it would take an
> army of 10,000+ full-time software engineers skilled
> in "Extreme Programming" and formal methods to be able
> to verify something of the complexity and intricacy of
> the Linux kernel within a single year, excluding any
> changes made during that time, which will likely
> replace so much of the code that the verification
> won't tell you much anyway.
> 
> If every company and every University involved in
> Linux - not just every consortium - were to
> contribute, you might be able to amass that kind of
> manpower. One full-time coder for the entire of the
> MIPS side of the tree is valuable and it's doubtful
> any branch could now survive long without at least
> that, one person is simply not capable of replacing
> ten thousand, no matter how brilliant they are.
> 

Well, I'm not sure about that. Now knowing that Ralf is not
maintaining/developing on linux-mips tree full time is a good
information to keep in mind. I think he's able to take care of any
MIPS specific code if he had time. The current number of patches sent
to linux-mips is not so big. Look at how Andrew Morton is maintaining
the mm branch. This branch is far more active and patches included in
this tree are far more complex than those sent to this mailing list.

> This isn't to say MIPS Tech should necessarily throw
> in more manpower, although I certainly wouldn't argue
> with that. It's that there's simply no realistic way
> to get enough manpower together to do code reviews in
> the kind of timeframes that people are asking for.
> 

Well IMHO MIPS Tech may be under-estimating its Linux kernel port. I
think it's a real advantage to sell some hardwares and to give some
softwares that is already running on that hardware, specially if this
software is a full operating system like Linux. But if MIPS' customers
don't know on how fast this software will involve, will be fixed, it's
a bit scaring to rely on that software.

It would be interesting to know how well Linux is supported on the
different arches keeping in mind the market that they are targeting
(embedded, huge server...).

		Franck
