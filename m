Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2QIgwx30213
	for linux-mips-outgoing; Mon, 26 Mar 2001 10:42:58 -0800
Received: from lacrosse.corp.redhat.com (host154.207-175-42.redhat.com [207.175.42.154])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2QIgwM30210
	for <linux-mips@oss.sgi.com>; Mon, 26 Mar 2001 10:42:58 -0800
Received: from mx.hsv.redhat.com (IDENT:root@spot.hsv.redhat.com [172.16.16.7])
	by lacrosse.corp.redhat.com (8.9.3/8.9.3) with ESMTP id NAA04790;
	Mon, 26 Mar 2001 13:42:51 -0500
Received: from redhat.com (IDENT:joe@uberdog.hsv.redhat.com [172.16.16.108])
	by mx.hsv.redhat.com (8.11.0/8.11.0) with ESMTP id f2QIj7x31555;
	Mon, 26 Mar 2001 12:45:07 -0600
Message-ID: <3ABF8ED5.2050007@redhat.com>
Date: Mon, 26 Mar 2001 12:47:49 -0600
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Embedded MIPS/Linux Needs
References: <00eb01c0b2c6$02c7ef60$0deca8c0@Ulysses> <3ABEB120.8020609@redhat.com> <20010326192559.A8385@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Florian Lohoff wrote:

> On Sun, Mar 25, 2001 at 09:01:52PM -0600, Joe deBlaquiere wrote:
> 
>> Just some unsorted random ideas:
>> 
>> 1. Would it be possible to lump some of the different MIPS variants
>> together more closely? In my dream world I could build one kernel that
>> would boot on every mips architecture. This way the work can be more
>> general. As it stands now, if you want Tx39 or Vr41 variants you're
>> working out of a different tree. With the number of SoC core products
>> coming out at present, this predicament is only likely to get more
>> serious. I know at one point in time you could boot a single ARM kernel on
>> several different systems and it would adapt it's processor specifics at
>> runtime. Such a design might help to bring the MIPS world together a bit.
> 
> 
> There is at least a problem with endianess - I dont think there can be
> a little and big endian kernel coexist in the same object or at least
> not with major rework.
> 

Well, yes that would be a problem, but at least within endianess, there's no reason why the processor specific stuff can't be abstracted and attached at runtime.

> Why would you suggest having vr41 and TX39 in a seperat tree ? I had a
> look in the linux-vr tree and i dont like some of their #ifdef spaghetti
> stuff so i am currently working on TX39 stuff on top of the oss tree
> which could be made cleanly. (Dont integrate all TX39 archs into one
> subarch *grrr*)
> 

It's kinda ugly, but some of that is that the original architecture didn't scale to having many different target platforms. I think a little sane multi-platform infrastructure would make things cleaner and better in the future.

> Flo


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
