Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 11:46:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15870 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816040AbaHRJpP3VCuK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Aug 2014 11:45:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1AD2D962A301C;
        Mon, 18 Aug 2014 10:45:03 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 18 Aug
 2014 10:45:04 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 18 Aug 2014 10:45:04 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 18 Aug
 2014 10:45:03 +0100
Message-ID: <53F1CB1D.5090204@imgtec.com>
Date:   Mon, 18 Aug 2014 10:45:01 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Bhaskar Valaboju <bvalaboj@ikanos.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: kallsyms crash on MIPS InterAptiv
References: <EAFF944E7F196B48B283913C2A0034A5049AE9A3@SVFRWEXCH1.ikanos.com>
In-Reply-To: <EAFF944E7F196B48B283913C2A0034A5049AE9A3@SVFRWEXCH1.ikanos.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Bhaskar,

On 18/08/14 10:08, Bhaskar Valaboju wrote:
> Hello all,
> Our platform is based on MIPS InterAptive, dual core processor where 3.10.28 kernel is ported.  Following crash is observed when /proc/kallsyms is read:

The mainline kernel didn't support interAptiv until v3.14. Are you using
the MTI tree?

If so I suggest contacting Imagination for support, and trying to
reproduce the problem with an untainted kernel (i.e. without any
proprietary (P) or forced (F) kernel modules loaded), to give us the
best chance of reproducing it.

Thanks
James

> root@OpenWrt:/# tail /proc/kallsyms
> [  779.350000] CPU 0 Unable to handle kernel paging request at virtual address 18b1b900, epc == 801ab8e0, ra == 80080c8c
> [  779.360000] Oops[#1]:
> [  779.360000] CPU: 0 PID: 1925 Comm: tail Tainted: PF            3.10.28 #1
> [  779.360000] task: 8ee22078 ti: 88b12000 task.ti: 88b12000
> [  779.360000] $ 0   : 00000000 00000000 18b1b900 8c595e40
> [  779.360000] $ 4   : 8c5a0591 18b1b900 00000080 00000003
> [  779.360000] $ 8   : 8c5a0590 00000001 00000001 80409f34
> [  779.360000] $12   : 0000000f 0000030b 00000000 69745f6e
> [  779.360000] $16   : 8c595ce0 8c5a0591 8c5a0588 88b13f10
> [  779.360000] $20   : 8c7c4480 00001024 0047e1cc 8e53da28
> [  779.360000] $24   : 00000000 77204fc8
> [  779.360000] $28   : 88b12000 88b13dc8 8c5a0580 80080c8c
> [  779.360000] Hi    : 00000355
> [  779.360000] Lo    : 00022a42
> [  779.360000] epc   : 801ab8e0 strlcpy+0x20/0x74
> [  779.360000]     Tainted: PF
> [  779.360000] ra    : 80080c8c module_get_kallsym+0xa4/0x160
> [  779.360000] Status: 11009c03 KERNEL EXL IE
> [  779.360000] Cause : 00800008
> [  779.360000] BadVA : 18b1b900
> [  779.360000] PrId  : 0001a120 (MIPS interAptiv)
> [  779.360000] Modules linked in: ahci_vx585 xhci_hcd ext2 vfat fat nls_iso8859_1 nls_cp437 nls_ascii umac(F) ath_dev(PF) ath_dfs(PF) ath_rate_atheros(PF) ath_hal(PF) asf(PF) adf(PF) athr83xx_lkm(F) ipqos_lkm(F) vdsldriver_lkm(F) atmdriver_lkm(F) bmedrv(F) ap_stats_lkm(F) monif_lkm(F) pppRelay_lkm(F) sysKCode_lkm(PF) aclap_driver_lkm(F) classifier_driver_lkm(F) ethdriver_lkm(F) nf_nat_sip nf_conntrack_sip nf_nat_ftp nf_conntrack_ftp periap_driver_lkm(F) timers_lkm(F) bmdriver_lkm(PF) ap2ap_lkm(PF) crypto_hw_lkm(F) fusivlib_lkm(F) spi_driver_lkm(F) opensrc_lkm(F) iptable_nat(F) ipt_MASQUERADE(F) ebtable_nat(F) ebtable_filter(F) ebtable_broute(F) xt_time(F) xt_tcpmss(F) xt_string(F) xt_statistic(F) xt_state(F) xt_recent(F) xt_quota(F) xt_policy(F) xt_pkttype(F) xt_physdev(F) xt_owner(F) xt_nat(F) xt_multiport(F) xt_mark(F) xt_mac(F) xt_limit(F) xt_length(F) xt_iprange(F) xt_helper(F) xt_esp(F) xt_ecn(F) xt_dscp(F) xt_conntrack(F) xt_connmark(F) xt_connbytes(F) xt_comment(F) x
 t!
>  _addrtype(F) xt_TCPMSS(F) xt_REDIRECT(F) xt_NETMAP(F) xt_LOG(F) xt_HL(F) xt_DSCP(F) xt_CT(F) xt_CLASSIFY(F) ts_kmp(F) ts_fsm(F) ts_bm(F) ppp_async(F) nf_nat_ipv4(F) nf_nat(F) l2tp_ppp(F) iptable_raw(F) ipt_ah(F) ipt_ECN(F) ebtables(F) ebt_vlan(F) ebt_stp(F) ebt_redirect(F) ebt_pkttype(F) ebt_mark_m(F) ebt_mark(F) ebt_limit(F) ebt_among(F) ebt_802_3(F) fuse(F) act_skbedit(F) act_mirred(F) em_u32(F) cls_u32(F) cls_tcindex(F) cls_flow(F) cls_route(F) cls_fw(F) sch_hfsc(F) sch_ingress(F) ip6t_mh(F) ip6t_ah(F) ip6table_raw(F) l2tp_netlink(F) l2tp_core(F) ipcomp6(F) xfrm6_tunnel(F) esp6(F) ah6(F) ipcomp(F) xfrm4_tunnel(F) xfrm4_mode_transport(F) xfrm4_mode_tunnel(F) xfrm4_mode_beet(F) esp4(F) ah4(F) xfrm_ipcomp(F) chainiv(F) eseqiv(F) crypto_wq(F) sha256_generic(F) sha1_generic(F) krng(F) rng(F) md5(F) hmac(F) des_generic(F) cbc(F) authenc(F) crypto_blkcipher(F) aead(F) usb_storage(F) sd_mod(F) ext4(F) jbd2(F) mbcache(F) crypto_hash(F)
> [  779.360000] Process tail (pid: 1925, threadinfo=88b12000, task=8ee22078, tls=772ac440)
> [  779.360000] Stack : ffffffff ffffffff ffffffff 8c7c4480 8c595ce0 8c5a0591 8c5a0588 80080c8c
>           00000007 88b13f10 8c7c4480 00001024 0047e1cc 8e53da28 8c595ce4 800e4f88
>           8c5a0580 00000fff 00000007 8008162c 8e53da00 800e4fe4 88b12000 88b13e48
>           8c5a0611 8c5a0650 000039d0 00000355 00022a42 8c5a0580 00000fff 80081788
>           8c5201dc 00000054 8c5a0591 8c5a0611 8e53da00 800e4b70 00000000 f0000363
>           ...
> [  779.360000] Call Trace:
> [  779.360000] [<801ab8e0>] strlcpy+0x20/0x74
> [  779.360000] [<80080c8c>] module_get_kallsym+0xa4/0x160
> [  779.360000] [<8008162c>] update_iter+0x68/0x18c
> [  779.360000] [<80081788>] s_next+0x38/0x50
> [  779.360000] [<800e4b70>] seq_read+0x33c/0x530
> [  779.360000] [<80111e1c>] proc_reg_read+0x60/0xa4
> [  779.360000] [<800c1e20>] vfs_read+0xa4/0x160
> [  779.360000] [<800c258c>] SyS_read+0x58/0xa4
> [  779.360000] [<8001269c>] stack_done+0x20/0x44
> [  779.360000]
> [  779.360000]
> Code: afb00010  0806ae38  00808821 <80430000> 1460fffe  24420001  2442ffff  10c00009  00458023
> [  779.710000] ---[ end trace 41823b3754909b39 ]---
> Segmentation fault
> 
> Please let me know if anyone encountered this crash and fix is available.
> 
> Thanks,
> -Bhaskar
> 
