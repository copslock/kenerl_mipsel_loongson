Received:  by oss.sgi.com id <S554012AbQLERu0>;
	Tue, 5 Dec 2000 09:50:26 -0800
Received: from u-153-21.karlsruhe.ipdial.viaginterkom.de ([62.180.21.153]:36368
        "EHLO u-153-21.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S554007AbQLERuT>; Tue, 5 Dec 2000 09:50:19 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S868868AbQLERuF>;
	Tue, 5 Dec 2000 18:50:05 +0100
Date:	Tue, 5 Dec 2000 18:50:05 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Calvine Chew <calvine@sgi.com>
Cc:	'Martin Michlmayr' <tbm@cyrius.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: oss ftp server down?
Message-ID: <20001205185005.B16354@bacchus.dhis.org>
References: <43FECA7CDC4CD411A4A3009027999112267CC4@sgp-apsa001e--n.singapore.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <43FECA7CDC4CD411A4A3009027999112267CC4@sgp-apsa001e--n.singapore.sgi.com>; from calvine@sgi.com on Tue, Dec 05, 2000 at 05:47:34PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Dec 05, 2000 at 05:47:34PM +0800, Calvine Chew wrote:

> That's really weird. I used to be able to access the oss.sgi.com ftp server
> until recently... I keep getting timeouts...

[ralf@lappi ralf]$ ssh oss.sgi.com uptime
  9:47am  up 12 days, 17:23,  0 users,  load average: 0.00, 0.00, 0.00
[ralf@lappi ralf]$ 

Inside SGI those timeouts are usually explained by an incorrect SOCKS
client setup.

SOCKS sucks.  Spell all uppercase.

  Ralf
