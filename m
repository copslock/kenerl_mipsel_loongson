Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBHIAcB26762
	for linux-mips-outgoing; Mon, 17 Dec 2001 10:10:38 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBHIAZo26758
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 10:10:35 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 2C4B4125C0; Mon, 17 Dec 2001 09:10:32 -0800 (PST)
Date: Mon, 17 Dec 2001 09:10:32 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andreas Jaeger <aj@suse.de>,
   GNU libc hacker <libc-hacker@sources.redhat.com>,
   binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Prelink for mips (Re: MIPS broken in 2.3)
Message-ID: <20011217091032.A29014@lucon.org>
References: <u8ellzsg3q.fsf@gromit.moeb> <20011213093958.A6057@lucon.org> <hou1uqclnk.fsf@gee.suse.de> <20011217123631.G542@sunsite.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011217123631.G542@sunsite.ms.mff.cuni.cz>; from jakub@redhat.com on Mon, Dec 17, 2001 at 12:36:31PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 17, 2001 at 12:36:31PM +0100, Jakub Jelinek wrote:

> instead (well, best would be if somebody ported prelink to mips;
> I'll try to answer any questions and help).

Do you have some documentations how prelink works?

> I skipped mips because it is way too different from how any other ELF
> architecture works (e.g. using a single dynamic reloc type for everything
> with various meanings, etc.) and I have no access to it.

That is what I am afraid of. The MIPS ABI supports "quickstart". I
don't know if we can add prelink to mips without breaking/changing
the MIPS ABI. I don't want to spend my time on it if it can't be done
at all.



H.J.
