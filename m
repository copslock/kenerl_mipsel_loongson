Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADJKma22906
	for linux-mips-outgoing; Tue, 13 Nov 2001 11:20:48 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADJKk022903
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 11:20:46 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fADJLjB13741;
	Tue, 13 Nov 2001 11:21:45 -0800
Subject: Re: gt-64120 bootloader??
From: Pete Popov <ppopov@mvista.com>
To: "Joe Y." <joey@medialincs.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <20011113092119.GA7142@medialincs.com>
References: <20011113092119.GA7142@medialincs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 13 Nov 2001 11:22:58 -0800
Message-Id: <1005679378.29107.18.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2001-11-13 at 01:21, Joe Y. wrote:
> anyone know bootloader for the galileo 64120 board ?
> 
> PMON or redboot is not support gt-64120.. 
> 
> I looking for having ability to load linux. 
> 
> if you have any experience, inform to me.

If it's one of Galileo's eval boards, it should have pmon running on it
already. Unfortunately their pmon only supports serial port downloads of
srec files, so it takes about 6 minutes to download the kernel.

Pete
