Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g09497n16283
	for linux-mips-outgoing; Tue, 8 Jan 2002 20:09:07 -0800
Received: from netbank.com.br (IDENT:postfix@garrincha.netbank.com.br [200.203.199.88])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0948vg16279
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 20:08:58 -0800
Received: from brinquedo.distro.conectiva (3-115.ctame701-2.telepar.net.br [200.181.171.115])
	by netbank.com.br (Postfix) with ESMTP
	id CA05446827; Wed,  9 Jan 2002 01:05:04 -0200 (BRDT)
Received: by brinquedo.distro.conectiva (Postfix, from userid 501)
	id A5233C487; Wed,  9 Jan 2002 01:05:31 -0200 (BRST)
Date: Wed, 9 Jan 2002 01:05:30 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "machael thailer" <dony.he@huawei.com>
Cc: <linux-mips@oss.sgi.com>
Subject: Re: limited Memory question...
Message-ID: <20020109030530.GE23506@conectiva.com.br>
References: <003301c198af$1c0d0a80$9b6e0b0a@huawei.com> <20020109015128.GB23506@conectiva.com.br> <000f01c198b6$d627ffe0$9b6e0b0a@huawei.com> <20020109024443.GD23506@conectiva.com.br> <001b01c198ba$0fc82b00$9b6e0b0a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001b01c198ba$0fc82b00$9b6e0b0a@huawei.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Em Wed, Jan 09, 2002 at 11:02:23AM +0800, machael thailer escreveu:
> 
> > Em Wed, Jan 09, 2002 at 10:39:18AM +0800, machael thailer escreveu:
> > > > > I have a question to need you help. Our MIPS-based custom board has only
> > > > > 8M memory.When I want to insmod a 24M module, it often panics and says
> > > > > "out of memory...".
> > > > 
> > > > a kernel module? 24MiB? ouch, if that is the case, the only way is to get
> > > > more memory for your board, as kernel memory is not swappable...
> > > 
> > > Yes, it is a kernel module.  
> > > But unfortunately, the memory is fixed on our board and we cannot add more memory.
> > > Any other ideas?
> > 
> > What does this module does that takes so much memory? One possible idea
> > akpm talked about was to reduce NR_CPUS to the number of CPUs in your eval
> > board if that is something relevant to the reason why your module takes so
> > much memory, does it have a firmware linked? If so, don't link it and load
> > it from userspace, block by block, if this is possible, etc, other than
> > these suggestions one could only give more ideas if the source code is
> > available for review.
> 
> 24M is the size of the module, not the memory that it takes.

what is the output of:

size your_module.o

?

- Arnaldo
