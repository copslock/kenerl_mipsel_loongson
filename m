Received:  by oss.sgi.com id <S553776AbQJYAmr>;
	Tue, 24 Oct 2000 17:42:47 -0700
Received: from u-66.karlsruhe.ipdial.viaginterkom.de ([62.180.19.66]:261 "EHLO
        u-66.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553675AbQJYAmS>; Tue, 24 Oct 2000 17:42:18 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869752AbQJYAl4>;
        Wed, 25 Oct 2000 02:41:56 +0200
Date:   Wed, 25 Oct 2000 02:41:56 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: gcc : ... is greater than maximum object file alignment
Message-ID: <20001025024156.B10792@bacchus.dhis.org>
References: <39F626C9.96146652@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39F626C9.96146652@mvista.com>; from jsun@mvista.com on Tue, Oct 24, 2000 at 05:18:17PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 05:18:17PM -0700, Jun Sun wrote:

> I looked carefully again at the output for building glibc, and I found
> the following warnings.  If I remembered correctly, Ralf has already
> fixed a similar problem a while back.  Maybe it is not in the patch
> file?  I am using egcs-1.0.3a-2.diff.gz on oss.sgi.com site.
> 
> pthread.c:31: warning: alignment of `__pthread_initial_thread' is
> greater than maximum object file alignment
> pthread.c:62: warning: alignment of `__pthread_manager_thread' is
> greater than maximum object file alignment

The fix was only available as part of the cross-egcs-1.0.3a-2 package but
not us unbundled patch.  It's now available there.  Note that the
native compiler also isn't based on this latest patch.

  Ralf
