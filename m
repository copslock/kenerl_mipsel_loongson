Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f55Nm9W25299
	for linux-mips-outgoing; Tue, 5 Jun 2001 16:48:09 -0700
Received: from elaine27.Stanford.EDU (elaine27.Stanford.EDU [171.64.15.102])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f55Nm9h25296
	for <linux-mips@oss.sgi.com>; Tue, 5 Jun 2001 16:48:09 -0700
Received: (from johnd@localhost)
	by elaine27.Stanford.EDU (8.11.1/8.11.1) id f55Nlvq24854;
	Tue, 5 Jun 2001 16:47:57 -0700 (PDT)
Date: Tue, 5 Jun 2001 16:47:57 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: Robert Rusek <robru@teknuts.com>
cc: <linux-mips@oss.sgi.com>
Subject: Re: Newbie Question, Please help
In-Reply-To: <002e01c0ee0c$1572fed0$031010ac@rjrtower>
Message-ID: <Pine.GSO.4.31.0106051640220.24775-100000@elaine27.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You should make sure that the vmlinux kernel is nfsroot configured. Check
the config-* file for CONFIG_ROOT_NFS=y.  Also read the nfsroot.txt in the
cvs Documentation directory for more info.  I found that getting the linux
filesystem from a linux box works best.  The major and minor nodes for the
/dev directory are correct.  Also, a useful installation page is located
at:

http://www.stafwag.f2s.com/indy/?lang=eng

I found this helpful.
john davis

On Tue, 5 Jun 2001, Robert Rusek wrote:

> I just got a SGI Challenge S.  I need advice on which flavor of Linux I should install, RedHat or Debian.  Which is the better choice.  I also need to find out how to install this.  I already attempted and failed to install the RedHat 5.1.  I am using a RedHat 7.0 box to do the install (bootp/tftp/nfs) but I am not even able to get the setup to run.  I am using the latest version of DHCP/BOOTP (ics 2.0) to try to boot.  It gets the address then claims it is sending the vmlinux file via tftp.  On the SGI it just times out.
>
> Any advice, pointers, etc would be greatly appreciated.
>
> Thanks in advance,
> Robert Ruserk
>
