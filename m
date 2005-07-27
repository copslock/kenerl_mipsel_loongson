Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2005 18:22:12 +0100 (BST)
Received: from localhost.localdomain ([IPv6:::ffff:127.0.0.1]:48862 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225751AbVG0RVw>; Wed, 27 Jul 2005 18:21:52 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6RHOS1V011749;
	Wed, 27 Jul 2005 13:24:28 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6RHORvW011748;
	Wed, 27 Jul 2005 13:24:27 -0400
Date:	Wed, 27 Jul 2005 13:24:27 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Niels Sterrenburg <pulsar@kpsws.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050727172427.GB3626@linux-mips.org>
References: <20050725213607Z8225534-3678+4335@linux-mips.org> <57480.194.171.252.100.1122478386.squirrel@mail.kpsws.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57480.194.171.252.100.1122478386.squirrel@mail.kpsws.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 27, 2005 at 05:33:06PM +0200, Niels Sterrenburg wrote:

> Do you detect and fix these trailing whitespaces with a script ?
> If so can you tell me where I can find it (or send it)?

Well, here's my nuke-trailing-whitespace skript.  Pretty small - 80% of it
is the legalese and a brief comment.  In case you're using quilt you
can do something like

  nuke-trailing-whitespace `quilt files`
  quilt refresh --diffstat

to clean a particular patch

  Ralf

#! /bin/bash
#
# Copyright (C) 2002 by Ralf Baechle (ralf@linux-mips.org)
#
#  This program is free software; you can redistribute  it and/or modify it
#  under  the terms of  the GNU General  Public License as published by the
#  Free Software Foundation;  either version 2 of the  License, or (at your
#  option) any later version.
#
#  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
#  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
#  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
#  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
#  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#  You should have received a copy of the  GNU General Public License along
#  with this program; if not, write  to the Free Software Foundation, Inc.,
#  675 Mass Ave, Cambridge, MA 02139, USA.
#
# nuke-trailing-whitespace - Nuke trailing whitespace in sourcecode
#
# Usage: nuke-trailing-whitespace [file]...
#

find $*  -name CVS -prune -o -type f -print | \
	fgrep -v defconfig |
	xargs --no-run-if-empty -- perl -pi -e 's/[ \t]+$//'
