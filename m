Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0942I215941
	for linux-mips-outgoing; Tue, 8 Jan 2002 20:02:18 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0942Dg15919;
	Tue, 8 Jan 2002 20:02:13 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 16O9BM-0008W9-00; Wed, 09 Jan 2002 03:13:40 +0000
Subject: Re: limited Memory question...
To: dony.he@huawei.com (machael thailer)
Date: Wed, 9 Jan 2002 03:13:40 +0000 (GMT)
Cc: linux-mips@oss.sgi.com, ralf@oss.sgi.com (Ralf Baechle)
In-Reply-To: <003301c198af$1c0d0a80$9b6e0b0a@huawei.com> from "machael thailer" at Jan 09, 2002 09:43:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16O9BM-0008W9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>     I have a question to need you help. Our MIPS-based custom board has only
> 8M memory.When I want to insmod a 24M module, it often panics and says "out 
> of memory...".
> How can I solve this?

Stop the module using 24Mb of unpageable memory ?
