Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9J2eH113208
	for linux-mips-outgoing; Thu, 18 Oct 2001 19:40:17 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9J2eGD13205
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 19:40:16 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E247E125C3; Thu, 18 Oct 2001 19:40:14 -0700 (PDT)
Date: Thu, 18 Oct 2001 19:40:14 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Strange behavior of serial console under 2.4.9
Message-ID: <20011018194014.A8744@lucon.org>
References: <20011018185717.A8135@lucon.org> <007201c15843$57067a60$3501010a@ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <007201c15843$57067a60$3501010a@ltc.com>; from brad@ltc.com on Thu, Oct 18, 2001 at 10:11:18PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Oct 18, 2001 at 10:11:18PM -0400, Bradley D. LaRonde wrote:
> I haven't noticed that.  I just ran top with 0 delay at 115200 and it seems
> normally fast to me.
> 

I am using 9600 buad. It used to be ok under 2.4.3/2.4.5. But under
2.4.9, the first 10 minutes after boot is very slow. After that, it
seems ok.


H.J.
