Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7KLAKd31098
	for linux-mips-outgoing; Mon, 20 Aug 2001 14:10:20 -0700
Received: from dea.linux-mips.net (u-145-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.145])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7KLAH931090
	for <linux-mips@oss.sgi.com>; Mon, 20 Aug 2001 14:10:17 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7KL7tt11340;
	Mon, 20 Aug 2001 23:07:55 +0200
Date: Mon, 20 Aug 2001 23:07:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: questions about eret....
Message-ID: <20010820230755.A11242@dea.linux-mips.net>
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000b01c1295e$0f2174c0$8021690a@huawei.com>; from dony.he@huawei.com on Mon, Aug 20, 2001 at 05:54:09PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 20, 2001 at 05:54:09PM +0800, machael thailer wrote:

>     I have a question to ask about eret.
> 
>     In RC4xxx/RC32334, after eret finished, does it automatically enable IE
> bit of STATUS register?

ERET does not influence the state of the IE bit.

  Ralf
