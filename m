Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA67s8607701
	for linux-mips-outgoing; Mon, 5 Nov 2001 23:54:08 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fA67s6007697
	for <linux-mips@oss.sgi.com>; Mon, 5 Nov 2001 23:54:06 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fA67rTH28179;
	Mon, 5 Nov 2001 23:53:29 -0800
Date: Mon, 5 Nov 2001 23:53:29 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: hz_to_std
Message-ID: <20011105235329.C18038@dea.linux-mips.net>
References: <067801c1656e$1f5274b0$3501010a@ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <067801c1656e$1f5274b0$3501010a@ltc.com>; from brad@ltc.com on Sun, Nov 04, 2001 at 03:20:03PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Nov 04, 2001 at 03:20:03PM -0500, Bradley D. LaRonde wrote:
> From: "Bradley D. LaRonde" <brad@ltc.com>
> To: <linux-mips@oss.sgi.com>
> Subject: hz_to_std
> Date: Sun, 4 Nov 2001 15:20:03 -0500
> 
> What is the intent and purpose of the hz_to_std stuff?

DECstation needs to be built with HZ != 100 but we have to keep the API
uninfluenced by this.

  Ralf
