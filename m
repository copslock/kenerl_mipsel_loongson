Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACLors12638
	for linux-mips-outgoing; Mon, 12 Nov 2001 13:50:53 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACLoo012632;
	Mon, 12 Nov 2001 13:50:50 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fACLoTjV031837;
	Mon, 12 Nov 2001 13:50:29 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fACLoSo3031833;
	Mon, 12 Nov 2001 13:50:28 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Mon, 12 Nov 2001 13:50:28 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Han-Seong Kim <khs@digital-digital.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: Power MGMT on mips
In-Reply-To: <20011112233031.A6493@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.10.10111121349420.26939-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > 2.If no, how can manage CPU and Bidge chips for power mgnt ?
> 
> Right now Linux/MIPS will only use the CPU's power managment features, that
> is the wait instruction or similar.

What would be nice that I have been thinking about is making a cpu scale
api very similiar to what ARM has. 
