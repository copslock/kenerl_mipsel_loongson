Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 12:59:51 +0000 (GMT)
Received: from erebor.lep.brno.cas.cz ([IPv6:::ffff:195.178.65.162]:45836 "EHLO
	erebor.lep.brno.cas.cz") by linux-mips.org with ESMTP
	id <S8226018AbTAHM7u>; Wed, 8 Jan 2003 12:59:50 +0000
Received: from ladis by erebor.lep.brno.cas.cz with local (Exim 3.12 #1 (Debian))
	id 18WFwR-0004yw-00; Wed, 08 Jan 2003 14:08:19 +0100
Date: Wed, 8 Jan 2003 14:08:19 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Guido Guenther <agx@sigxcpu.org>
Subject: Re: Remove GIO interface
Message-ID: <20030108140818.C17162@erebor.psi.cz>
References: <20030108133013.A17162@erebor.psi.cz> <Pine.GSO.3.96.1030108133732.1580C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030108133732.1580C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jan 08, 2003 at 01:41:41PM +0100
From: Ladislav Michl <ladis@psi.cz>
Return-Path: <ladis@psi.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@psi.cz
Precedence: bulk
X-list: linux-mips

On Wed, Jan 08, 2003 at 01:41:41PM +0100, Maciej W. Rozycki wrote:
> On Wed, 8 Jan 2003, Ladislav Michl wrote:
> 
> > * Even in case everything work as stated in documentation, we are unable
> >   to use this mechanism to detect Newport for console driver (the main
> >   reason why I created this interface was to provide neccessary
> >   informations to Xserver), because our DBE handling doesn't work until
> >   modules are initialized (in case we are building kernel with modules
> >   support).
> 
>  That is a bug and it should be fixed.  What are the symptoms?

the most notable symptom is machine hang at boot time :-) it doesn't apply
to cvs kernel, just to my private one where I called get_dbe in console_init.
you cannot use get_dbe _before_ init_modules is called (ie. in board_irq_init).
reason is following (copy&paste from traps.c). read "READ HERE".

static inline unsigned long
search_dbe_table(unsigned long addr)
{
        unsigned long ret = 0;

#ifndef CONFIG_MODULES
        /* There is only the kernel to search.  */
        ret = search_one_table(__start___dbe_table, __stop___dbe_table-1, addr);
        return ret;
#else
        unsigned long flags;

        /* The kernel is the last "module" -- no need to treat it special.  */
        struct module *mp;
        struct archdata *ap;

        spin_lock_irqsave(&modlist_lock, flags);
        for (mp = module_list; mp != NULL; mp = mp->next) {
                if (!mod_member_present(mp, archdata_end) ||
                    !mod_archdata_member_present(mp, struct archdata,
                                                 dbe_table_end))
                        continue;
                ap = (struct archdata *)(mp->archdata_start);

                if (ap->dbe_table_start == NULL ||
                    !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
                        continue;
/* READ HERE: we don't reach this point because kernel is the last module
 * and it is not initialized yet, so it has no archdata */
                ret = search_one_table(ap->dbe_table_start,
                                       ap->dbe_table_end - 1, addr);
                if (ret)
                        break;
        }
        spin_unlock_irqrestore(&modlist_lock, flags);
        return ret;
#endif
}

so although traps are initialized one cannot use them and have to wait
until modules are initialized too.

anyway, even if you fix this issue it is not reason for keeping GIO
interface.

	ladis
