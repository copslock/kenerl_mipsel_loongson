Received:  by oss.sgi.com id <S553852AbRAKLsa>;
	Thu, 11 Jan 2001 03:48:30 -0800
Received: from slag.lineo.com ([64.50.107.170]:43781 "HELO slag.lineo.com")
	by oss.sgi.com with SMTP id <S553815AbRAKLsP>;
	Thu, 11 Jan 2001 03:48:15 -0800
Received: by slag.lineo.com (Postfix, from userid 1000)
	id EB095188721; Thu, 11 Jan 2001 04:48:08 -0700 (MST)
Date:   Thu, 11 Jan 2001 04:48:08 -0700
From:   Erik Andersen <andersen@lineo.com>
To:     Michael Shmulevich <michaels@jungo.com>
Cc:     busybox@opensource.lineo.com,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: [BusyBox] 0.48 - Can't mount /proc
Message-ID: <20010111044808.A1592@lineo.com>
Reply-To: andersen@lineo.com
References: <3A5CAC53.60700@jungo.com> <20010110122159.A24714@lineo.com> <3A5D609C.2080201@jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5D609C.2080201@jungo.com>; from michaels@jungo.com on Thu, Jan 11, 2001 at 09:28:28AM +0200
X-Operating-System: Linux 2.2.18pre9, AMD Athlon, 704.938 MHz
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu Jan 11, 2001 at 09:28:28AM +0200, Michael Shmulevich wrote:
> Erik,
> 
> No, doesn't help.
> 
> bash# mount proc /proc -t proc                                          
>        
> mount: Mounting proc on /proc failed: Unknown error 716878944           
>        
> 
> Maybe people in mips-linux know something about this?

Yes, this does sound like a kernel specific problem then,
since this works on (at least) arm, ppc, sh, and x86.
I havn't tried it on anything else.

 -Erik

--
Erik B. Andersen   email:  andersen@lineo.com
--This message was written using 73% post-consumer electrons--
