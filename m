Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g092t1m12575
	for linux-mips-outgoing; Tue, 8 Jan 2002 18:55:01 -0800
Received: from netbank.com.br (IDENT:postfix@garrincha.netbank.com.br [200.203.199.88])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g092svg12566;
	Tue, 8 Jan 2002 18:54:57 -0800
Received: from brinquedo.distro.conectiva (3-115.ctame701-2.telepar.net.br [200.181.171.115])
	by netbank.com.br (Postfix) with ESMTP
	id 190354680E; Tue,  8 Jan 2002 23:51:04 -0200 (BRDT)
Received: by brinquedo.distro.conectiva (Postfix, from userid 501)
	id 59BD3C487; Tue,  8 Jan 2002 23:51:29 -0200 (BRST)
Date: Tue, 8 Jan 2002 23:51:29 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "machael thailer" <dony.he@huawei.com>
Cc: <linux-mips@oss.sgi.com>, "Ralf Baechle" <ralf@oss.sgi.com>
Subject: Re: limited Memory question...
Message-ID: <20020109015128.GB23506@conectiva.com.br>
References: <003301c198af$1c0d0a80$9b6e0b0a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003301c198af$1c0d0a80$9b6e0b0a@huawei.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Em Wed, Jan 09, 2002 at 09:43:59AM +0800, machael thailer escreveu:

> I have a question to need you help. Our MIPS-based custom board has only
> 8M memory.When I want to insmod a 24M module, it often panics and says
> "out of memory...".

a kernel module? 24MiB? ouch, if that is the case, the only way is to get
more memory for your board, as kernel memory is not swappable...

- Arnaldo
