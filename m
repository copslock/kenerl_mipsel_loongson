Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 21:03:15 +0000 (GMT)
Received: from vps1.tull.net ([66.180.172.116]:14045 "HELO vps1.tull.net")
	by ftp.linux-mips.org with SMTP id S24149833AbYLEVDD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2008 21:03:03 +0000
Received: (qmail 2854 invoked by uid 1015); 6 Dec 2008 08:02:56 +1100
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Sat, 06 Dec 2008 08:02:56 +1100
Received: (qmail 20892 invoked by uid 1000); 6 Dec 2008 08:02:53 +1100
Date:	Sat, 6 Dec 2008 08:02:53 +1100
From:	Nick Andrew <nick@nick-andrew.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Jonathan Corbet <corbet@lwn.net>,
	"Kevin D. Kissell" <kevink@paralogos.com>,
	Lucas Woods <woodzy@gmail.com>, linux-mips@linux-mips.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix incorrect use of loose in vpe.c
Message-ID: <20081205210253.GD5957@mail.local.tull.net>
References: <S24119814AbYLEAhF/20081205003705Z+5882@ftp.linux-mips.org> <20081205155654.GA2765@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081205155654.GA2765@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Return-Path: <nick@tull.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nick@nick-andrew.net
Precedence: bulk
X-list: linux-mips

On Fri, Dec 05, 2008 at 03:56:54PM +0000, Ralf Baechle wrote:
> Thanks, applied.  Note that the address you used for Kevin Kissel to post
> your patch is no longer valid.

Yep. By default the get_maintainers.pl script which I used trawls through
'git log' to find everybody who was involved in a commit in each affected
file during the last 12 months. Kevin signed off commit b618336aac14 from
his old address.

Nick.
-- 
PGP Key ID = 0x418487E7                      http://www.nick-andrew.net/
PGP Key fingerprint = B3ED 6894 8E49 1770 C24A  67E3 6266 6EB9 4184 87E7
