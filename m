Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2003 06:40:50 +0100 (BST)
Received: from rrcs-central-24-123-115-43.biz.rr.com ([IPv6:::ffff:24.123.115.43]:38404
	"EHLO Radium.intranet") by linux-mips.org with ESMTP
	id <S8225072AbTFCFks>; Tue, 3 Jun 2003 06:40:48 +0100
Received: from radium ([192.168.1.22])
	by Radium.intranet (8.9.3/8.9.3) with ESMTP id AAA31966;
	Tue, 3 Jun 2003 00:40:02 -0500
From: "Lyle Bainbridge" <lyle@zevion.com>
To: "'Dan Malek'" <dan@embeddededge.com>, <baitisj@evolution.com>
Cc: <n_gale@ok.ru>, <linux-mips@linux-mips.org>
Subject: RE: DBAu1500 board flash downloading
Date: Tue, 3 Jun 2003 00:40:36 -0500
Message-ID: <000201c32992$a844efc0$1601a8c0@radium>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3EDC29CB.1010409@embeddededge.com>
Return-Path: <lyle@zevion.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lyle@zevion.com
Precedence: bulk
X-list: linux-mips

Yeh, I second that.  The BDI-2000 has been a very valuable tool
for me, both for debugging and flash writing.  However, it runs
about $2500 for one architecture (ie, MIPS).  By the time you
purchase the Raven and the various software packages it's almost
as expensive, but isn't as good.  If money isn't a problem, the
BDI-2000 is the way to go.

Lyle


> 
> 
> Jeff Baitis wrote:
> 
> > Rather than building an EJTAG interface, I recommend the 
> Raven EJTAG 
> > interface. It plugs into your LPT port, and will plug into 
> the EJTAG 
> > interface on your DBAu1500 board.
> 
> I can recommend the Abatron BDI-2000 (www.abatron.ch).  It's 
> a powerful, flexible tool that will work in a variety of 
> development environments. In addition to providing debugging 
> features, it also has built-in flash programming algorithms.  
> You can erase/program flash with simple console or script 
> commands from various file formats transferred over the 
> network using tftp.
> 
> 
> 	-- Dan
> 
