Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 22:45:09 +0000 (GMT)
Received: from carisma.slowglass.com ([195.224.96.167]:61961 "EHLO
	phoenix.infradead.org") by linux-mips.org with ESMTP
	id <S8225241AbSLKWpJ>; Wed, 11 Dec 2002 22:45:09 +0000
Received: from hch by phoenix.infradead.org with local (Exim 4.10)
	id 18MFbH-0001ou-00; Wed, 11 Dec 2002 22:45:07 +0000
Date: Wed, 11 Dec 2002 22:45:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: ilya@theIlya.com
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: O2 VICE support
Message-ID: <20021211224507.A6807@infradead.org>
References: <20021210191120.GE609@gateway.total-knowledge.com> <20021211133831.A19300@infradead.org> <20021211221629.GP609@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021211221629.GP609@gateway.total-knowledge.com>; from ilya@theIlya.com on Wed, Dec 11, 2002 at 02:16:29PM -0800
Return-Path: <hch@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 11, 2002 at 02:16:29PM -0800, ilya@theIlya.com wrote:
> > > +    if (!filp->private_data) {
> > > +	filp->private_data = vice_device;
> > > +    }
> > 
> > filp->private_data can't be set.
> ???
> I can live without using it of course, since it isn't currently possible to have
> more then one instance of VICE in same machine, but theoretical possibility does
> exist. Where should I pass information about which specific device current
> call is?

Sorry if that sentence was confusing.  I meant it can't be already set in
->open so the if is superflous.

> > > +void vice_cleanup_module(void)
> > > +{
> > > +#ifndef CONFIG_DEVFS_FS
> > > +    /* cleanup_module is never called if registering failed */
> > > +    unregister_chrdev(vice_major, "vice");
> > > +#endif
> > 
> > Umm, just because someone makes the mistake of enabling devfs he
> > doesn't have to use it.. :)
> I'm not buying that one :)

You can have CONFIG_DEVFS_FS set but devfs not mounted and used.
Thus #ifndef CONFIG_DEVFS_FS code is a very bad idea.
