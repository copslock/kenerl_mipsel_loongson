Received:  by oss.sgi.com id <S553780AbRADRWx>;
	Thu, 4 Jan 2001 09:22:53 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:2043 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553661AbRADRWm>; Thu, 4 Jan 2001 09:22:42 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S868136AbRADRNm>;
	Thu, 4 Jan 2001 15:13:42 -0200
Date:	Thu, 4 Jan 2001 15:13:34 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Joe deBlaquiere <jadb@redhat.com>
Cc:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        John Van Horne <JohnVan.Horne@cosinecom.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        "'wesolows@foobazco.org'" <wesolows@foobazco.org>
Subject: Re: your mail
Message-ID: <20010104151334.C2525@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010104171213.4624E-100000@delta.ds2.pg.gda.pl> <3A54A789.1070608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A54A789.1070608@redhat.com>; from jadb@redhat.com on Thu, Jan 04, 2001 at 10:40:41AM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 04, 2001 at 10:40:41AM -0600, Joe deBlaquiere wrote:

> There is a bug in that "some" newer versions of objcopy will not allow 
> you to translate these sign-extended 32 bit addresses into Intel Hex 
> format.

I couldn't care less ...

> If you're really only doing 32-bit mips you might consider removing the 
> 64 bit targets in the config.bfd... I think that will solve the problems.

Doesn't really solve the problem.  For example on an Origin we have a 32-bit
userland but 64-bit kernel addresses which confuses ksymops and procps.

  Ralf
