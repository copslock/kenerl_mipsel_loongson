Received:  by oss.sgi.com id <S553667AbQLZU5O>;
	Tue, 26 Dec 2000 12:57:14 -0800
Received: from [194.213.32.137] ([194.213.32.137]:23813 "EHLO bug.ucw.cz")
	by oss.sgi.com with ESMTP id <S553652AbQLZU4v>;
	Tue, 26 Dec 2000 12:56:51 -0800
Received: (from pavel@localhost)
	by bug.ucw.cz (8.8.8/8.8.5) id VAA00698;
	Tue, 26 Dec 2000 21:53:17 +0100
Message-ID: <20001226215317.B628@bug.ucw.cz>
Date:   Tue, 26 Dec 2000 21:53:17 +0100
From:   Pavel Machek <pavel@suse.cz>
To:     Joe deBlaquiere <jadb@redhat.com>,
        Ralf Baechle <ralf@uni-koblenz.de>
Cc:     the list <linux-kernel@vger.kernel.org>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: sysmips call and glibc atomic set
References: <3A46F4D8.9060605@redhat.com> <20001226140204.D894@bacchus.dhis.org> <3A48CC1D.9000204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A48CC1D.9000204@redhat.com>; from Joe deBlaquiere on Tue, Dec 26, 2000 at 10:49:33AM -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi!

> > Not having swap doesn't mean you're safe.  Think of any kind of previously
> > unmapped page.
> > 
> 
> Is there a reason why it doesn't just force that page to be mapped
> first?

You can map it in... But background daemon can map it out in the
meantime :-). You'd have to map in and pagelock.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
