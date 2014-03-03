Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2014 00:37:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:45950 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822902AbaCCXhRoVK3B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2014 00:37:17 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 13C739343A265
        for <linux-mips@linux-mips.org>; Mon,  3 Mar 2014 23:37:07 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 3 Mar
 2014 23:37:10 +0000
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 3 Mar 2014 23:37:09 +0000
Received: from [192.168.159.189] (192.168.159.189) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 3 Mar
 2014 15:37:06 -0800
Message-ID: <5315121A.9050803@imgtec.com>
Date:   Mon, 3 Mar 2014 17:36:58 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     LMOL <linux-mips@linux-mips.org>
Subject: Release #2 of Linux MTI-3.10-LTS kernel.
Content-Type: multipart/mixed;
        boundary="------------000708010300060108040904"
X-Originating-IP: [192.168.159.189]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

--------------000708010300060108040904
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Imagination Technologies is pleased to announce the second release of
its 3.10 LTS (Long-Term Support) MIPS kernel. The attached ChangeLog
shows the new MTI patches added for this release and the all the stable
patches from Greg's 3.10.14 to 3.10.28 releases. The code repository is
hosted at the Linux/MIPS project GIT:

     GIT REPO:  git://git.linux-mips.org/pub/scm/linux-mti.git
  BRANCH NAME:  linux-mti-3.10
     TAG NAME:  linux-mti-3.10.28

We look forward to any comments or feedback.

         The Imagination MIPS Kernel Team

--------------000708010300060108040904
Content-Type: text/plain; charset="UTF-8"; name="ChangeLog-MTI-3.10.28"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ChangeLog-MTI-3.10.28"

***********************************************************
MTI changes from 'linux-mti-3.10.14' to 'linux-mti-3.10.28'
***********************************************************
cpuidle: coupled: disable IRQs after leaving safe state
cpuidle: declare cpuidle_dev in cpuidle.h
MIPS: Add 1074K CPU support explicitly.
MIPS: Add cases for CPU_P5600
MIPS: add CP0 CMGCRBase bit definitions
MIPS: add CPC probe, access functions
MIPS: add cpu_vpe_id macro
MIPS: Add MIPS P5600 cputype identifier
MIPS: add missing CPC, GIC register definitions
MIPS: add missing includes to gic.h
MIPS: Add P5600 PRid and probe support
MIPS: Add processor identifier for the M5150 processor
mips: add ".set push" ".set pop" pairs around ".set eva"
MIPS: Add support for the M5150 processor
MIPS: Add syscall_set_return_value system call
MIPS: asm: syscall: Add the syscall_rollback function
MIPS: asm: syscall: Define syscall_get_arch
MIPS: asm: syscall: Fix copying system call arguments
MIPS: asm: uaccess: Fix EVA #ifdef for __strncpy_from_user
MIPS: bugfix of coherentio variable default setup
MIPS: bugfix of "core" and "vpe_id" setup for MT ASE w/out GCMP
MIPS: bugfix of ebase WG bit mask
MIPS: bugfix of force-bev-location parsing
MIPS: CMP framework should depend on !SMTC, not on SMVP
MIPS: Coherent Processing System SMP implementation
MIPS: CPC: use __raw_ memory access functions
MIPS: cpuidle driver for MIPS CPS
mips: default NR_CPUS=8 for malta SMP defconfigs
MIPS: define Config1 cache field shifts & sizes
MIPS: Enable entries for SIGSYS in struct siginfo.
MIPS: Enable HAVE_ARCH_TRACEHOOK.
MIPS: Fix build error seen in some configurations
MIPS: Fix invalid detection of GCMP L2 SYNC support.
MIPS: fix warning when including smp-ops.h with CONFIG_SMP=n
MIPS: futex: Use LLE and SCE for EVA
MIPS: Implement task_user_regset_view.
MIPS: inst.h: define COP0 wait op
MIPS: inst.h: define microMIPS sync op
MIPS: inst.h: define microMIPS wait op
MIPS: introduce _EXT assembler macro
MIPS: kernel: cpu-probe: Add support for probing M5150 cores
MIPS: kernel: scalls: Skip the syscall if denied by the seccomp filter
MIPS: lib: memset: Drop unused EXE macro
MIPS: Malta: allow use of MIPS CPS SMP implementation
MIPS: Malta: GIC IPIs may be used without MT
MIPS: Malta: probe CPC when supported
MIPS: microMIPS: Remove unsupported compiler flag.
MIPS: more helpful CONFIG_MIPS_CMP help text, label
MIPS: Move audit_arch() helper function to __syscall_get_arch().
MIPS: move GIC IPI functions out of smp-cmp.c
MIPS: OProfile: Add CPU_P5600 cases
MIPS: OProfile: Add CPU_PROAPTIV case
MIPS: P5600: use CPU_P5600
MIPS: Provide arch_syscall_addr.
MIPS: provide empty mips_mt_set_cpuoptions when CONFIG_MIPS_MT=n
MIPS: ptrace: Move away from secure_computing_strict
mips: regenerate malta defconfigs
MIPS: seccomp: Handle indirect system calls (o32)
MIPS: Select HAVE_ARCH_SECCOMP_FILTER
mips: set page size to 16KB for malta SMP defconfigs
MIPS: smp-cps: don't run MT instructions if cpu doesn't have MT
MIPS: smp-cps: fix build when CONFIG_MIPS_MT_SMP=n
MIPS: smp-mt: use common GIC IPI implementation
MIPS: support use of cpuidle
MIPS: uasm: add a label variant of beq
MIPS: uasm: add jr.hb instruction
MIPS: uasm: add mftc0 & mttc0 instructions
MIPS: uasm: add sync instruction
MIPS: uasm: add wait instruction


********************************************
Stable changes from 'v3.10.14' to 'v3.10.28'
********************************************
6lowpan: Uncompression of traffic class field was incorrect
9p: send uevent after adding/removing mount_tag attribute
aacraid: missing capable() check in compat ioctl
aacraid: prevent invalid pointer dereference
ACPI / Battery: Add a _BIX quirk for NEC LZ750/LS
ACPICA: DeRefOf operator: Update to fully resolve FieldUnit and BufferField refs.
ACPICA: Fix for a Store->ArgX when ArgX contains a reference to a field.
ACPICA: Return error if DerefOf resolves to a null package element.
ACPI / EC: Ensure lock is acquired before accessing ec struct members
ACPI / hotplug: Do not execute "insert in progress" _OST
ACPI / hotplug: Fix conflicted PCI bridge notify handlers
ACPI / hotplug: Fix handle_root_bridge_removal()
ACPI / IPMI: Fix atomic context requirement of ipmi_msg_handler()
ACPI / TPM: fix memory leak when walking ACPI namespace
ACPI / video: Quirk initial backlight level 0
af_packet: block BH in prb_shutdown_retire_blk_timer()
ahci: Add Device IDs for Intel Wildcat Point-LP
ahci: add Marvell 9230 to the AHCI PCI device list
ahci: add PCI ID for Marvell 88SE9170 SATA controller
ahci: disabled FBS prior to issuing software reset
aio: restore locking of ioctx list on removal
alarmtimer: return EINVAL instead of ENOTSUPP if rtcdev doesn't exist
ALSA: 6fire: Fix probe of multiple cards
ALSA: Add SNDRV_PCM_STATE_PAUSED case in wait_for_avail function
ALSA: compress: Fix 64bit ABI incompatibility
ALSA: compress: Fix compress device unregister.
ALSA: compress: fix drain calls blocking other compress functions
ALSA: compress: fix drain calls blocking other compress functions (v6)
ALSA: fix oops in snd_pcm_info() caused by ASoC DPCM
ALSA: hda - Add a fixup for ASUS N76VZ
ALSA: hda - Add enable_msi=0 workaround for four HP machines
ALSA: hda - Add fixup for ASUS N56VZ
ALSA: hda - Add headset quirk for Dell Inspiron 3135
ALSA: hda - Add missing initial vmaster hook at build_controls callback
ALSA: hda - Add mono speaker quirk for Dell Inspiron 5439
ALSA: hda - Add pincfg fixup for ASUS W5A
ALSA: hda - Add static DAC/pin mapping for AD1986A codec
ALSA: hda - Add support for CX20952
ALSA: hda - Add support of ALC255 codecs
ALSA: hda - Another fixup for ASUS laptop with ALC660 codec
ALSA: hda - Check keep_eapd_on before inv_eapd
ALSA: hda - Check leaf nodes to find aamix amps
ALSA: hda - Create Headhpone Mic Jack Mode when really needed
ALSA: hda - Don't clear the power state at snd_hda_codec_reset()
ALSA: hda - Don't turn off EAPD for headphone on Lenovo N100
ALSA: hda - Enable SPDIF for Acer TravelMate 6293
ALSA: hda - Fix GPIO for Acer Aspire 3830TG
ALSA: hda - Fix headset mic input after muted internal mic (Dell/Realtek)
ALSA: hda - Fix hp-mic mode without VREF bits
ALSA: hda - Fix inverted internal mic not indicated on some machines
ALSA: hda - Fix Line Out automute on Realtek multifunction jacks
ALSA: hda - Fix microphone for Sony VAIO Pro 13 (Haswell model)
ALSA: hda - Fix mono speakers and headset mic on Dell Vostro 5470
ALSA: hda - Fix silent output on ASUS W7J laptop
ALSA: hda - Fix silent output on MacBook Air 2,1
ALSA: hda - Fix the headphone jack detection on Sony VAIO TX
ALSA: hda - Fix unbalanced runtime PM notification at resume
ALSA: hda - Fix unbalanced runtime PM refcount after S3/S4
ALSA: hda - hdmi: Fix channel map switch not taking effect
ALSA: hda - hdmi: Fix IEC958 ctl indexes for some simple HDMI devices
ALSA: hda - hdmi: Fix reported channel map on common default layouts
ALSA: hda - Initialize missing bass speaker pin for ASUS AIO ET2700
ALSA: hda - Make sure mute LEDs stay on during runtime suspend (Realtek)
ALSA: hda - Mute all aamix inputs as default
ALSA: hda - Provide missing pin configs for VAIO with ALC260
ALSA: hda/realtek - Add support of ALC231 codec
ALSA: hda/realtek - Set pcbeep amp for ALC668
ALSA: memalloc.h - fix wrong truncation of dma_addr_t
ALSA: msnd: Avoid duplicated driver name
ALSA: snd-usb-usx2y: remove bogus frame checks
ALSA: us122l: Fix pcm_usb_stream mmapping regression
ARC: Fix 32-bit wrap around in access_ok()
ARC: Fix signal frame management for SA_SIGINFO
ARC: Fix __udelay calculation
ARC: Handle zero-overhead-loop in unaligned access handler
ARC: Ignore ptrace SETREGSET request for synthetic register "stop_pc"
ARC: Incorrect mm reference used in vmalloc fault handler
ARC: Setup Vector Table Base in early boot
ARC: SMP failed to boot due to missing IVT setup
ARC: Workaround spinlock livelock in SMP SystemC simulation
arm64: Avoid cache flushing in flush_dcache_page()
arm64: Change kernel stack size to 16K
arm64: check for number of arguments in syscall_get/set_arguments()
arm64: Do not flush the D-cache for anonymous pages
arm64: dts: Reserve the memory used for secondary CPU release address
arm64: fix possible invalid FPSIMD initialization state
arm64: Only enable local interrupts after the CPU is marked online
arm64: ptrace: avoid using HW_BREAKPOINT_EMPTY for disabled events
arm64: Remove unused cpu_name ascii in arch/arm64/mm/proc.S
arm64: spinlock: retry trylock operation if strex fails on free lock
arm64: Use Normal NonCacheable memory for writecombine
arm64: virt: ensure visibility of __boot_cpu_mode
ARM: 7815/1: kexec: offline non panic CPUs on Kdump panic
ARM: 7837/3: fix Thumb-2 bug in AES assembler code
ARM: 7851/1: check for number of arguments in syscall_get/set_arguments()
ARM: 7876/1: clear Thumb-2 IT state on exception handling
ARM: 7912/1: check stack pointer in get_wchan
ARM: 7913/1: fix framepointer check in unwind_frame
ARM: 7938/1: OMAP4/highbank: Flush L2 cache before disabling
arm/arm64: KVM: Fix hyp mappings of vmalloc regions
ARM: at91: fix hanged boot due to early rtc-interrupt
ARM: at91: fix hanged boot due to early rtt-interrupt
ARM: at91: sama5d3: reduce TWI internal clock frequency
ARM: bcm2835: add missing #xxx-cells to I2C nodes
ARM: dts: Add max77686 RTC interrupt to cros5250-common
ARM: dts: exynos5250: Fix MDMA0 clock number
ARM: fix "bad mode in ... handler" message for undefined instructions
ARM: fix booting low-vectors machines
ARM: fix footbridge clockevent device
ARM: Fix the world famous typo with is_gate_vma()
ARM: footbridge: fix EBSA285 LEDs
ARM: footbridge: fix VGA initialisation
ARM: hyp: initialize CNTVOFF to zero
ARM: i.MX6q: fix the wrong parent of can_root clock
ARM: integrator_cp: Set LCD{0,1} enable lines when turning on CLCD
ARM: integrator: deactivate timer0 on the Integrator/CP
ARM: KVM: arch_timers: zero CNTVOFF upon return to host
ARM: mvebu: fix second and third PCIe unit of Armada XP mv78260
ARM: mvebu: second PCIe unit of Armada XP mv78230 is only x1 capable
ARM: mvebu: use the virtual CPU registers to access coherency registers
ARM: mxs: stub out mxs_pm_init for !CONFIG_PM
ARM: OMAP2+: hwmod_data: fix missing OMAP_INTC_START in irq data
ARM: OMAP2+: hwmod: Fix SOFTRESET logic
ARM: OMAP2+: irq, AM33XX add missing register check
ARM: OMAP3: hwmod data: Don't prevent RESET of USB Host module
ARM: pxa: prevent PXA270 occasional reboot freezes
ARM: pxa: tosa: fix keys mapping
ARM: sa11x0/assabet: ensure CS2 is configured appropriately
ARM: shmobile: armadillo: Fix coherent DMA mask
ARM: shmobile: kzm9g: Fix coherent DMA mask
ARM: shmobile: mackerel: Fix coherent DMA mask
ASoC: 88pm860x: array overflow in snd_soc_put_volsw_2r_st()
ASoC: ab8500-codec: info leak in anc_status_control_put()
ASoC: ak4642: prevent un-necessary changes to SG_SL1
ASoC: arizona: Set FLL to free-run before disabling
ASoC: blackfin: Fix missing break
ASoC: cs42l52: Correct MIC CTL mask
ASoC: dapm: Fix source list debugfs outputs
ASoC: fsl: imx-pcm-fiq: omit fiq counter to avoid harm in unbalanced situations
ASoC: max98095: a couple array underflows
ASoC: tegra: fix uninitialized variables in set_fmt
ASoC: wm5110: Add post SYSCLK register patch for rev D chip
ASoC: wm5110: Correct HPOUT3 DAPM route typo
ASoC: wm8731: fix dsp mode configuration
ASoC: wm8904: fix DSP mode B configuration
ASoC: wm8962: Turn on regcache_cache_only before disabling regulator
ASoC: wm8990: Mark the register map as dirty when powering down
ASoC: wm_adsp: Add small delay while polling DSP RAM start
ASoC: wm_hubs: Add missing break in hp_supply_event()
ath9k: Fix interrupt handling for the AR9002 family
ath9k: Fix QuickDrop usage
ath9k: fix tx queue scheduling after channel changes
ath9k: Fix XLNA bias strength
ath9k_htc: properly set MAC address and BSSID mask
atm: idt77252: fix dev refcnt leak
au1100fb: VM_IO is set by io_remap_pfn_range()
au1200fb: io_remap_pfn_range() sets VM_IO
audit: add child record before the create to handle case where create fails
audit: fix info leak in AUDIT_GET requests
audit: fix mq_open and mq_unlink to add the MQ root as a hidden parent audit_names record
audit: log the audit_names record type
audit: printk USER_AVC messages when audit isn't enabled
audit: use nlmsg_len() to get message payload length
auxvec.h: account for AT_HWCAP2 in AT_VECTOR_SIZE_BASE
avr32: fix clockevents kernel warning
avr32: fix out-of-range jump in large kernels
avr32: setup crt for early panic()
backlight: atmel-pwm-bl: fix deferred probe from __init
backlight: atmel-pwm-bl: fix gpio polarity in remove
backlight: atmel-pwm-bl: fix reported brightness
batman-adv: set up network coding packet handlers during module init
bcache: Fix a dumb CPU spinning bug in writeback
bcache: Fix a dumb journal discard bug
bcache: Fix a flush/fua performance bug
bcache: Fix a null ptr deref regression
bcache: Fix a shrinker deadlock
bcache: Fix a writeback performance regression
bcache: Fixed incorrect order of arguments to bio_alloc_bioset()
bcache: Fix flushes in writeback mode
bcache: Fix for handling overlapping extents when reading in a btree node
bcache: Fix for when no journal entries are found
bcache: Strip endline when writing the label through sysfs
be2net: pass if_id for v1 and V2 versions of TX_CREATE cmd
blk-core: Fix memory corruption if blkcg_init_queue fails
block: fix a probe argument to blk_register_region
block: Fix bio_copy_data()
block: fix race between request completion and timeout handling
block: properly stack underlying max_segment_size to DM device
Bluetooth: Add a new PID/VID 0cf3/e005 for AR3012.
Bluetooth: Add support for BCM20702A0 [0b05, 17cb]
Bluetooth: Fix encryption key size for peripheral role
Bluetooth: Fix rfkill functionality during the HCI setup stage
Bluetooth: Fix security level for peripheral role
Bluetooth: Introduce a new HCI_RFKILLED flag
bnx2x: record rx queue for LRO packets
bonding: don't permit to use ARP monitoring in 802.3ad mode
bonding: Fix broken promiscuity reference counting issue
bonding: fix two race conditions in bond_store_updelay/downdelay
brcmfmac: obtain platform data upon module initialization
bridge: Clamp forward_delay when enabling STP
bridge: Correctly clamp MAX forward_delay when enabling STP
bridge: fix NULL pointer deref of br_port_get_rcu
bridge: flush br's address entry in fdb when remove the bridge dev
bridge: use br_port_get_rtnl within rtnl lock
bridge: use spin_lock_bh() in br_multicast_set_hash_max
btrfs: call mnt_drop_write after interrupted subvol deletion
Btrfs: change how we queue blocks for backref checking
Btrfs: do not run snapshot-aware defragment on error
Btrfs: fix access_ok() check in btrfs_ioctl_send()
Btrfs: fix hole check in log_one_extent
Btrfs: fix incorrect inode acl reset
Btrfs: fix memory leak of chunks' extent map
Btrfs: remove ourselves from the cluster list under lock
Btrfs: skip subvol entries when checking if we've created a dir already
Btrfs: use right root when checking for hash collision
caif: Add missing braces to multiline if in cfctrl_linkup_request
can: at91-can: fix device to driver data mapping for platform devices
can: c_can: don't call pm_runtime_get_sync() from interrupt context
can: c_can: Fix RX message handling, handle lost message before EOB
can: dev: fix nlmsg size calculation in can_get_size()
can: flexcan: fix flexcan_chip_start() on imx6
can: flexcan: fix mx28 detection by rearanging OF match table
can: flexcan: flexcan_chip_start: fix regression, mark one MB for TX and abort pending TX
can: kvaser_usb: fix usb endpoints detection
can: peak_usb: fix mem leak in pcan_usb_pro_init()
can: sja1000: fix {pre,post}_irq() handling and IRQ handler return value
cciss: fix info leak in cciss_ioctl32_passthru()
ceph: Add check returned value on func ceph_calc_ceph_pg.
ceph: allow sync_read/write return partial successed size of read/write.
ceph: avoid accessing invalid memory
ceph: Avoid data inconsistency due to d-cache aliasing in readpage()
ceph: cleanup aborted requests when re-sending requests.
ceph: cleanup types in striped_read()
ceph: fix bugs about handling short-read for sync read mode.
ceph: fix null pointer dereference
ceph: Free mdsc if alloc mdsc->mdsmap failed.
ceph: improve error handling in ceph_mdsmap_decode
ceph: wake up 'safe' waiters when unregistering request
cfg80211: fix scheduled scan pointer access
cfg80211: fix warning when using WEXT for IBSS
cgroup: fix to break the while loop in cgroup_attach_task() correctly
cgroup: use a dedicated workqueue for cgroup destruction
clk: armada-370: fix tclk frequencies
clk: clk-divider: fix divisor > 255 bug
clk: exynos5250: fix sysmmu_mfc{l,r} gate clocks
clk: fixup argument order when setting VCO parameters
clk: samsung: exynos4: Correct SRC_MFC register
clk: samsung: exynos5250: Add CLK_IGNORE_UNUSED flag for the sysreg clock
clockevents: Add module refcount
clockevents: Get rid of the notifier chain
clockevents: Prefer CPU local devices over global devices
clockevents: Sanitize ticks to nsec conversion
clockevents: Split out selection logic
clocksource: arch_timer: use virtual counters
clocksource: dw_apb_timer_of: Fix read_sched_clock
clocksource: em_sti: Set cpu_possible_mask to fix SMP broadcast
compiler/gcc4: Add quirk for 'asm goto' miscompilation bug
configfs: fix race between dentry put and lookup
connector: improved unaligned access error fix
connector: use nlmsg_len() to check message length
cope with potentially long ->d_dname() output for shmem/hugetlb
cpqarray: fix info leak in ida_locked_ioctl()
cpufreq: highbank-cpufreq: Enable Midway/ECX-2000
cpufreq / intel_pstate: Fix max_perf_pct on resume
cpupower: Fix segfault due to incorrect getopt_long arugments
cpuset: Fix memory allocator deadlock
cris: media platform drivers: fix build
crypto: ansi_cprng - Fix off by one error in non-block size request
crypto: authenc - Find proper IV address in ablkcipher callback
crypto: ccm - Fix handling of zero plaintext when computing mac
crypto: s390 - Fix aes-cbc IV corruption
crypto: s390 - Fix aes-xts parameter corruption
crypto: scatterwalk - Set the chain pointer indication bit
crypto: scatterwalk - Use sg_chain_ptr on chain entries
cxd2820r_core: fix sparse warnings
cxgb3: Fix length calculation in write_ofld_wr() on 32-bit architectures
davinci_emac.c: Fix IFF_ALLMULTI setup
devpts: plug the memory leak in kill_sb
dm9601: fix IFF_ALLMULTI handling
dm9601: fix reception of full size ethernet frames on dm9620/dm9621a
dm9601: work around tx fifo sync issue on dm962x
dmaengine: imx-dma: fix callback path in tasklet
dmaengine: imx-dma: fix lockdep issue between irqhandler and tasklet
dmaengine: imx-dma: fix slow path issue in prep_dma_cyclic
dm: allocate buffer for messages with small number of arguments using GFP_NOIO
dm array: fix a reference counting bug in shadow_ablock
dm array: fix bug in growing array
dm bufio: initialize read-only module parameters
dm cache: fix a race condition between queuing new migrations and quiescing for a shutdown
dm delay: fix a possible deadlock due to shared workqueue
dmi: add support for exact DMI matches in addition to substring matching
dm mpath: disable WRITE SAME if it fails
dm mpath: fix race condition between multipath_dtr and pg_init_done
dm-raid: silence compiler warning on rebuilds_per_group.
dm snapshot: avoid snapshot space leak on crash
dm snapshot: fix data corruption
dm-snapshot: fix performance degradation due to small hash size
dm snapshot: workaround for a false positive lockdep warning
dm space map metadata: return on failure in sm_metadata_new_block
dm table: fail dm_table_create on dm_round_up overflow
dm thin: switch to read only mode if a mapping insert fails
driver core : Fix use after free of dev->parent in device_shutdown
drivers/char/i8k.c: add Dell XPLS L421X
drivers/libata: Set max sector to 65535 for Slimtype DVD A DS8A9SH drive
drivers/net/hamradio: Integer overflow in hdlcdrv_ioctl()
drivers/rtc/rtc-at91rm9200.c: correct alarm over day/month wrap
drm/edid: add quirk for BPC in Samsung NP700G7A-S01PL notebook
drm/i915: Don't grab crtc mutexes in intel_modeset_gem_init()
drm/i915: don't update the dri1 breadcrumb with modesetting
drm/i915/dp: increase i2c-over-aux retry interval on AUX DEFER
drm/i915: fix DDI PLLs HW state readout code
drm/i915: fix gen4 digital port hotplug definitions
drm/i915: Fix pipe CSC post offset calculation
drm/i915: flush cursors harder
drm/i915: Hold mutex across i915_gem_release
drm/i915: No LVDS hardware on Intel D410PT and D425KT
drm/i915: Only apply DPMS to the encoder if enabled
drm/i915: preserve pipe A quirk in i9xx_set_pipeconf
drm/i915: quirk away phantom LVDS on Intel's D510MO mainboard
drm/i915: Take modeset locks around intel_modeset_setup_hw_state()
drm/i915/tv: clear adjusted_mode.flags
drm/i915: Use the correct GMCH_CTRL register for Sandybridge+
drm/nouveau/bios/init: stub opcode 0xaa
drm/nouveau/bios: make jump conditional
drm/nouveau: when bailing out of a pushbuf ioctl, do not remove previous fence
drm/nv50-/disp: remove dcb_outp_match call, and related variables
drm/nva3-/disp: fix hda eld writing, needs to be padded
drm: Pad drm_mode_get_connector to 64-bit boundary
drm: Prevent overwriting from userspace underallocating core ioctl structs
drm/radeon: 0x9649 is SUMO2 not SUMO
drm/radeon: activate UVD clocks before sending the destroy msg
drm/radeon: add missing display tiling setup for oland
drm/radeon: add missing hdmi callbacks for rv6xx
drm/radeon/atom: workaround vbios bug in transmitter table on rs780
drm/radeon/audio: correct ACR table
drm/radeon/audio: improve ACR calculation
drm/radeon: avoid UVD corruption on AGP cards using GPU gart
drm/radeon: disable tests/benchmarks if accel is disabled
drm/radeon: don't share PPLLs on DCE4.1
drm/radeon: fix asic gfx values for scrapper asics
drm/radeon: fix hdmi audio on DCE3.0/3.1 asics
drm/radeon: fix hw contexts for SUMO2 asics
drm/radeon: fix N/CTS clock matching for audio
drm/radeon: Fix sideport problems on certain RS690 boards
drm/radeon: fix typo in CP DMA register headers
drm/radeon: fixup bad vram size on SI
drm/radeon: fix UVD 256MB check
drm/radeon: forever loop on error in radeon_do_test_moves()
drm/radeon: Make r100_cp_ring_info() and radeon_ring_gfx() safe (v2)
drm/radeon: program DCE2 audio dto just like DCE3
drm/radeon: re-enable sw ACR support on pre-DCE4
drm/radeon/si: fix define for MC_SEQ_TRAIN_WAKEUP_CNTL
drm/radeon: use 64-bit math to calculate CTS values for audio (v2)
drm/radeon: use hw generated CTS/N values for audio
drm/radeon/vm: don't attempt to update ptes if ib allocation fails
drm/ttm: Fix memory type compatibility check
drm/ttm: Fix ttm_bo_move_memcpy
drm/ttm: Handle in-memory region copies
drm/vmwgfx: Don't kill clients on VT switch
drm/vmwgfx: Don't put resources with invalid id's on lru list
ecryptfs: Fix memory leakage in keystore.c
edac, highbank: Fix interrupt setup of mem and l2 controller
elevator: acquire q->sysfs_lock in elevator_change()
elevator: Fix a race in elevator switching and md device initialization
esp_scsi: Fix tag state corruption when autosensing.
exec/ptrace: fix get_dumpable() incorrect tests
ext4: add explicit casts when masking cluster sizes
ext4: avoid bh leak in retry path of ext4_expand_extra_isize_ea()
ext4: call ext4_error_inode() if jbd2_journal_dirty_metadata() fails
ext4: check for overlapping extents in ext4_valid_extent_entries()
ext4: Do not reserve clusters when fs doesn't support extents
ext4: fix bigalloc regression
ext4: fix deadlock when writing in ENOSPC conditions
ext4: fix FITRIM in no journal mode
ext4: fix memory leak in xattr
ext4: fix use-after-free in ext4_mb_new_blocks
farsync: fix info leak in ioctl
firewire: sbp2: bring back WRITE SAME support
Fix a few incorrectly checked [io_]remap_pfn_range() calls
fs/binfmt_elf.c: prevent a coredump with a large vm_map_count from Oopsing
fsl/usb: Resolve PHY_CLK_VLD instability issue for ULPI phy
ftrace: Fix function graph with loading of modules
ftrace: Initialize the ftrace profiler for each possible cpu
ftrace/x86: Load ftrace_ops in parameter not the variable holding it
ftrace/x86: skip over the breakpoint for ftrace caller
fuse: fix fallocate vs. ftruncate race
fuse: wait for writeback in fuse_file_fallocate()
futex: fix handling of read-only-mapped hugepages
GFS2: don't hold s_umount over blkdev_put
GFS2: Fix incorrect invalidation for DIO/buffered I/O
GFS2: Increase i_writecount during gfs2_setattr_chown
gpio/lynxpoint: check if the interrupt is enabled in IRQ handler
gpio: msm: Fix irq mask/unmask by writing bits instead of numbers
gpio: mvebu: make mvchip->irqbase signed for error handling
gpio/omap: auto-setup a GPIO when used as an IRQ
gpio/omap: maintain GPIO and IRQ usage separately
gpio: pl061: move irqdomain initialization
gpio: rcar: NULL dereference on error in probe()
gpio-rcar: R-Car GPIO IRQ share interrupt
gpio: twl4030: Fix regression for twl gpio LED output
gpio: twl4030: Fix regression for twl gpio output
hamradio/yam: fix info leak in ioctl
HID: apple: option to swap the 'Option' ("Alt") and 'Command' ("Flag") keys.
HID: don't ignore eGalax/D-Wav/EETI HIDs
HID: enable Mayflash USB Gamecube Adapter
HID: fix data access in implement()
HID: fix unused rsize usage
HID:hid-lg4ff: Initialize device properties before we touch autocentering.
HID:hid-lg4ff: Scale autocentering force properly on Logitech wheel
HID:hid-lg4ff: Switch autocentering off when strength is set to zero.
HID: hid-multitouch: add support for SiS panels
HID: hid-sensor-hub: fix report size
HID: lg: fix ReportDescriptor for Logitech Formula Vibration
HID: lg: fix Report Descriptor for Logitech MOMO Force (Black)
HID: logitech - lg2ff: Add IDs for Formula Vibration Feedback Wheel
HID: multicouh: add PID VID to support 1 new Wistron optical touch device
HID: multitouch: Fix GeneralTouch products and add more PIDs
HID: Revert "Revert "HID: Fix logitech-dj: missing Unifying device issue""
HID: roccat: add missing special driver declarations
HID: roccat: add new device return value
HID: roccat: add support for KonePureOptical v2
HID: roccat: fix Coverity CID 141438
HID: uhid: add devname module alias
HID: uhid: allocate static minor
HID: uhid: fix leak for 64/32 UHID_CREATE
HID: usbhid: quirk for SiS Touchscreen
HID: usbhid: quirk for Synaptics Large Touchccreen
hwmon: (applesmc) Always read until end of data
hwmon: (applesmc) Check key count before proceeding
hwmon: (coretemp) Fix truncated name of alarm attributes
hwmon: HIH-6130: Support I2C bus drivers without I2C_FUNC_SMBUS_QUICK
hwmon: (lm90) Fix max6696 alarm handling
hwmon: Prevent some divide by zeros in FAN_TO_REG()
hwmon: (w83l768ng) Fix fan speed control range
hwmon: (w83l786ng) Fix fan speed control mode setting and reporting
hyperv-fb: add pci stub
i2c: ismt: initialize DMA buffer
i2c: mux: gpio: use gpio_set_value_cansleep()
i2c: mux: gpio: use reg value for i2c_add_mux_adapter
i2c: omap: Clear ARDY bit twice
IB/ipath: Convert ipath_user_sdma_pin_pages() to use get_user_pages_fast()
IB/qib: Fix txselect regression
IB/srp: Report receive errors correctly
ib_srpt: always set response for task management
ib_srpt: Destroy cm_id before destroying QP.
igb: Fix for issue where values could be too high for udelay function.
iio:accel:kxsd9 fix missing mutex unlock
iio:adc:ad7887 Fix channel reported endianness from cpu to big endian
iio:imu:adis16400 fix pressure channel scan type
inet: fix addr_len/msg->msg_namelen assignment in recv_error and rxpmtu functions
inet: fix possible memory corruption with UDP_CORK and UFO
inet: fix possible seqlock deadlocks
inet: prevent leakage of uninitialized memory to user in recv syscalls
Input: allocate absinfo data when setting ABS capability
Input: allow deselecting serio drivers even without CONFIG_EXPERT
Input: cypress_ps2 - do not consider data bad if palm is detected
Input: evdev - fall back to vmalloc for client event buffer
Input: i8042 - add PNP modaliases
Input: mousedev - allow disabling even without CONFIG_EXPERT
Input: usbtouchscreen: ignore eGalax/D-Wav/EETI HIDs
Input: usbtouchscreen - separate report and transmit buffer size handling
Input: xpad - add signature for Razer Onza Classic Edition
intel_pstate: Add X86_FEATURE_APERFMPERF to cpu match parameters.
intel_pstate: Fail initialization if P-state information is missing
ioatdma: fix sed pool selection
ioatdma: fix selection of 16 vs 8 source path
iommu: Remove stack trace from broken irq remapping warning
iommu/vt-d: Fixed interaction of VFIO_IOMMU_MAP_DMA with IOMMU address limits
ip6_output: fragment outgoing reassembled skb properly
ip6tnl: allow to use rtnl ops on fb tunnel
ip6tnl: fix use after free of fb_tnl_dev
ip6_tunnels: raddr and laddr are inverted in nl msg
ipc: close open coded spin lock calls
ipc: document general ipc locking scheme
ipc: drop ipcctl_pre_down
ipc: drop ipc_lock_by_ptr
ipc: drop ipc_lock_check
ipc: fix race with LSMs
ipc: introduce ipc object locking helpers
ipc: move locking out of ipcctl_pre_down_nolock
ipc: move rcu lock out of ipc_addid
ipc/msg.c: Fix lost wakeup in msgsnd().
ipc,msg: drop msg_unlock
ipc, msg: fix message length check for negative values
ipc, msg: forbid negative values for "msg{max,mnb,mni}"
ipc,msg: introduce lockless functions to obtain the ipc object
ipc,msg: introduce msgctl_nolock
ipc,msg: make msgctl_nolock lockless
ipc,msg: prevent race with rmid in msgsnd,msgrcv
ipc,msg: shorten critical region in msgctl_down
ipc,msg: shorten critical region in msgrcv
ipc,msg: shorten critical region in msgsnd
ipc: remove unused functions
ipc: rename ids->rw_mutex
ipc/sem.c: always use only one queue for alter operations
ipc/sem.c: cacheline align the semaphore structures
ipc/sem.c: fix race in sem_lock()
ipc/sem.c: optimize sem_lock()
ipc/sem.c: rename try_atomic_semop() to perform_atomic_semop(), docu update
ipc/sem.c: replace shared sem_otime with per-semaphore value
ipc/sem.c: synchronize semop and semctl with IPC_RMID
ipc/sem.c: synchronize the proc interface
ipc/sem.c: update sem_otime for all operations
ipc/sem: separate wait-for-zero and alter tasks into seperate queues
ipc,shm: cleanup do_shmat pasta
ipc,shm: correct error return value in shmctl (SHM_UNLOCK)
ipc, shm: drop shm_lock_check
ipc,shm: fix shm_file deletion races
ipc, shm: guard against non-existant vma in shmdt(2)
ipc,shm: introduce lockless functions to obtain the ipc object
ipc,shm: introduce shmctl_nolock
ipc,shm: make shmctl_nolock lockless
ipc,shm: shorten critical region for shmat
ipc,shm: shorten critical region for shmctl
ipc,shm: shorten critical region in shmctl_down
ipc: update locking scheme comments
ipc/util.c, ipc_rcu_alloc: cacheline align allocation
ip: generate unique IP identificator if local fragmentation is allowed
ip_gre: fix msg_name parsing for recvfrom/recvmsg
ip_gre: Fix WCCPv2 header parsing.
ip_tunnel: Fix a memory corruption in ip_tunnel_xmit
ip: use ip_hdr() in __ip_make_skb() to retrieve IP header
ipv4: fix ineffective source address selection
ipv4: fix possible seqlock deadlock
ipv4: fix race in concurrent ip_route_input_slow()
ipv4 igmp: use in_dev_put in timer handlers instead of __in_dev_put
ipv6: always prefer rt6i_gateway if present
ipv6: always set the new created dst's from in ip6_rt_copy
ipv6: don't count addrconf generated routes against gc limit
ipv6/exthdrs: accept tlv which includes only padding
ipv6: fill rt6i_gateway with nexthop address
IPv6: Fixed support for blackhole and prohibit routes
ipv6: fix headroom calculation in udp6_ufo_fragment
ipv6: fix illegal mac_header comparison on 32bit
ipv6: fix leaking uninitialized port number of offender sockaddr
ipv6: fix possible seqlock deadlock in ip6_finish_output2
ipv6: gre: correct calculation of max_headroom
ipv6: ip6_dst_check needs to check for expired dst_entries
ipv6 mcast: use in6_dev_put in timer handlers instead of __in6_dev_put
IPv6 NAT: Do not drop DNATed 6to4/6rd packets
ipv6: probe routes asynchronous in rt6_probe
ipv6: protect for_each_sk_fl_rcu in mem_check with rcu_read_lock_bh
ipv6: reset dst.expires value when clearing expire flag
ipv6: udp packets following an UFO enqueued packet need also be handled by UFO
ipv6: use rt6_get_dflt_router to get default router in rt6_route_rcv
irqchip: renesas-irqc: Fix irqc_probe error handling
irq: Enable all irqs unconditionally in irq_resume
irq: Force hardirq exit's softirq processing on its own stack
iscsi-target: chap auth shouldn't match username with trailing garbage
iscsi-target: fix extract_param to handle buffer length corner case
iscsi-target: Fix mutex_trylock usage in iscsit_increment_maxcmdsn
iscsi-target: Fix-up all zero data-length CDBs with R/W_BIT set
iscsi-target: Only perform wait_for_tasks when performing shutdown
isdnloop: use strlcpy() instead of strcpy()
iser-target: fix error return code in isert_create_device_ib_res()
iwl3945: better skb management in rx path
iwl4965: better skb management in rx path
iwlwifi: add new 7260 and 3160 series device IDs
iwlwifi: don't WARN on host commands sent when firmware is dead
iwlwifi: dvm: don't override mac80211's queue setting
iwlwifi: mvm: check sta_id/drain values in debugfs
iwlwifi: pcie: add new SKUs for 7000 & 3160 NIC series
iwlwifi: pcie: add SKUs for 6000, 6005 and 6235 series
jbd2: don't BUG but return ENOSPC if a handle runs out of space
jfs: fix error path in ialloc
KVM: Improve create VCPU parameter (CVE-2013-4587)
KVM: IOMMU: hva align mapping page size
KVM: PPC: Book3S HV: Fix typo in saving DSCR
KVM: x86: Convert vapic synchronization to _cached functions (CVE-2013-6368)
KVM: x86: Fix APIC map calculation after re-enabling
KVM: x86: fix emulation of "movzbl %bpl, %eax"
KVM: x86: fix guest-initiated crash with x2apic (CVE-2013-6376)
KVM: x86: Fix potential divide by 0 in lapic (CVE-2013-6367)
l2tp: Fix build warning with ipv6 disabled.
l2tp: fix kernel panic when using IPv4-mapped IPv6 addresses
l2tp: must disable bh before calling l2tp_xmit_skb()
libata: add ATA_HORKAGE_BROKEN_FPDMA_AA quirk for Seagate Momentus SpinPoint M8
libata: Add atapi_dmadir force flag
libata: disable a disk via libata.force params
libata: Fix display of sata speed
libata, freezer: avoid block device removal while system is frozen
libata: make ata_eh_qc_retry() bump scmd->allowed on bogus failures
libceph: add function to ensure notifies are complete
libceph: add lingering request reference when registered
libceph: call r_unsafe_callback when unsafe reply is received
libceph: create_singlethread_workqueue() doesn't return ERR_PTRs
libceph: fix error handling in handle_reply()
libceph: fix safe completion
libceph: fix truncate size calculation
libceph: potential NULL dereference in ceph_osdc_handle_map()
libertas: potential oops in debugfs
lib/genalloc.c: fix overflow of ending address of memory chunk
lib/scatterlist.c: don't flush_kernel_dcache_page on slab page
ll_temac: Reset dma descriptors indexes on ndo_open
loop: fix crash if blk_alloc_queue fails
loop: fix crash when using unassigned loop device
mac80211: correctly close cancelled scans
mac80211: don't attempt to reorder multicast frames
mac80211: drop spoofed packets in ad-hoc mode
mac80211: fix crash if bitrate calculation goes wrong
mac80211: move "bufferable MMPDU" check to fix AP mode scan
mac80211: update sta->last_rx on acked tx frames
mac80211: use sta_info_get_bss() for nl80211 tx and client probing
macvtap: Do not double-count received packets
macvtap: limit head length of skb allocated
macvtap: signal truncated packets
macvtap: update file current position
md: avoid deadlock when md_set_badblocks.
md: fix calculation of stacking limits on level change.
md: fix problem when adding device to read-only array with bitmap.
md: Fix skipping recovery for read-only arrays.
md/raid10: fix bug when raid10 recovery fails to recover a block.
md/raid10: fix two bugs in handling of known-bad-blocks.
md/raid5: Fix possible confusion when multiple write errors occur.
media: af9015: Don't use dynamic static allocation
media: af9033: fix broken I2C
media: af9035: add [0413:6a05] Leadtek WinFast DTV Dongle Dual
media: af9035: Don't use dynamic static allocation
media: af9035: fix broken I2C and USB I/O
media: af9035: unlock on error in af9035_i2c_master_xfer()
media: av7110_hw: Don't use dynamic static allocation
media: bttv: don't setup the controls if there are no video devices
media: cimax2: Don't use dynamic static allocation
media: cx18: struct i2c_client is too big for stack
media: cx23885: Fix TeVii S471 regression since introduction of ts2020
media: cxusb: Don't use dynamic static allocation
media: dibusb-common: Don't use dynamic static allocation
media: dvb-frontends: Don't use dynamic static allocation
media: dvb-frontends: Don't use dynamic static allocation
media: dw2102: Don't use dynamic static allocation
media: lirc_zilog: Don't use dynamic static allocation
media: mxl111sf: Don't use dynamic static allocation
media: s5h1420: Don't use dynamic static allocation
media: saa7164: fix return value check in saa7164_initdev()
media: sh_vou: almost forever loop in sh_vou_try_fmt_vid_out()
media: stb0899_drv: Don't use dynamic static allocation
media: stv0367: Don't use dynamic static allocation
media: stv090x: Don't use dynamic static allocation
media: tuners: Don't use dynamic static allocation
media: tuner-xc2028: Don't use dynamic static allocation
media: wm8775: fix broken audio routing
mei: add 9 series PCH mei device ids
mei: bus: stop wait for read during cl state transition
mei: cancel stall timers in mei_reset
mei: make me client counters less error prone
mei: me: add Lynx Point Wellsburg work station device id
mei: nfc: fix memory leak in error path
memcg: fix memcg_size() calculation
mfd: rtsx_pcr: Disable interrupts before cancelling delayed works
MIPS: DMA: For BMIPS5000 cores flush region just like non-coherent R10000
misc: atmel_pwm: add deferred-probing support
mm: Account for a THP NUMA hinting update as one PTE update
mm: avoid reinserting isolated balloon pages into LRU lists
mm/bounce.c: fix a regression where MS_SNAP_STABLE (stable pages snapshotting) was ignored
mmc: atmel-mci: abort transfer on timeout error
mmc: atmel-mci: fix oops in atmci_tasklet_func
mmc: block: fix a bug of error handling in MMC driver
mm: clear pmd_numa before invalidating
mm: Close races between THP migration and PMD numa clearing
mm/compaction: respect ignore_skip_hint in update_pageblock_skip
mm: ensure get_unmapped_area() returns higher address than mmap_min_addr
mm: fix BUG in __split_huge_page_pmd
mm: Fix generic hugetlb pte check return type.
mm: fix TLB flush race between migration, and change_protection_range
mm: fix use-after-free in sys_remap_file_pages
mm/hugetlb: check for pte NULL pointer in __page_check_address()
mm: make generic_access_phys available for modules
mm: Make {,set}page_address() static inline if WANT_PAGE_VIRTUAL
mm/memory-failure.c: recheck PageHuge() after hugetlb page migrate successfully
mm/memory-failure.c: transfer page count from head page to tail page after split thp
mm: numa: avoid unnecessary work on the failure path
mm: numa: Do not account for a hinting fault if we raced
mm: numa: ensure anon_vma is locked to prevent parallel THP splits
mm: numa: guarantee that tlb_flush_pending updates are visible before page table updates
mm: numa: return the number of base pages altered by protection changes
mm: numa: Sanitize task_numa_fault() callsites
mm/pagewalk.c: fix walk_page_range() access of wrong PTEs
mm: Prevent parallel splits during THP migration
mm/vmalloc.c: fix an overflow bug in alloc_vmap_area()
mm: Wait for THP migrations to complete during NUMA hinting faults
mtd: gpmi: fix kernel BUG due to racing DMA operations
mtd: map: fixed bug in 64-bit systems
mtd: nand: hack ONFI for non-power-of-2 dimensions
mwifiex: correct packet length for packets from SDIO interface
mwifiex: fix hang issue for USB chipsets
mwifiex: fix memory corruption when unsetting multicast list
mwifiex: fix memory leak issue for ibss join
mwifiex: fix NULL pointer dereference in usb suspend handler
mwifiex: fix PCIe hs_cfg cancel cmd timeout
mwifiex: fix SDIO interrupt lost issue
mwifiex: fix wrong eth_hdr usage for bridged packets in AP mode
net: 8139cp: fix a BUG_ON triggered by wrong bytes_compl
net: add BUG_ON if kernel advertises msg_namelen > sizeof(struct sockaddr_storage)
net: clamp ->msg_namelen instead of returning an error
net: core: Always propagate flag changes to interfaces
net:dccp: do not report ICMP redirects to user space
net_dma: mark broken
net: do not call sock_put() on TIMEWAIT sockets
net: do not pretend FRAGLIST support
net: drop_monitor: fix the value of maxattr
net: dst: provide accessor function to dst->xfrm
net: fec: fix potential use after free
net: fib: fib6_add: fix potential NULL pointer dereference
netfilter: nf_conntrack: fix rt6i_gateway checks for H.323 helper
netfilter: nf_conntrack: use RCU safe kfree for conntrack extensions
netfilter: nf_nat: fix access to uninitialized buffer in IRC NAT helper
netfilter: push reasm skb through instead of original frag skbs
net: fix cipso packet validation when !NETLABEL
net: Fix "ip rule delete table 256"
net: fix multiqueue selection
net: flow_dissector: fail on evil iph->ihl
net: flow_dissector: fix thoff for IPPROTO_AH
net: heap overflow in __audit_sockaddr()
net: inet_diag: zero out uninitialized idiag_{src,dst} fields
net: llc: fix use after free in llc_ui_recvmsg
net: Loosen constraints for recalculating checksum in skb_segment()
net/mlx4_core: Fix call to __mlx4_unregister_mac
net/mlx4_en: Fixed crash when port type is changed
net: mv643xx_eth: fix orphaned statistics timer crash
net: mv643xx_eth: update statistics timer from timer context only
net: net_secret should not depend on TCP
netpoll: Fix missing TXQ unlock and and OOPS.
netpoll: fix NULL pointer dereference in netpoll_cleanup
netpoll: Should handle ETH_P_ARP other than ETH_P_IP in netpoll_neigh_reply
net: qmi_wwan: add new Qualcomm devices
net: rework recvmsg handler msg_name and msg_namelen logic
net: rose: restore old recvmsg behavior
net_sched: htb: fix a typo in htb_change_class()
net: sctp: fix bug in sctp_poll for SOCK_SELECT_ERR_QUEUE
net: sctp: fix ipv6 ipsec encryption bug in sctp_v6_xmit
net: sctp: fix smatch warning in sctp_send_asconf_del_ip
net: sctp: rfc4443: do not report ICMP redirects to user space
net: secure_seq: Fix warning when CONFIG_IPV6 and CONFIG_INET are not selected
net: smc91: fix crash regression on the versatile
net-tcp: fix panic in tcp_fastopen_cache_set()
net: unix: allow bind to fail on mutex lock
net: unix: allow set_peek_off to fail
net: unix: inherit SOCK_PASS{CRED, SEC} flags from socket to fix race
net: update consumers of MSG_MORE to recognize MSG_SENDPAGE_NOTLAST
net: update consumers of MSG_MORE to recognize MSG_SENDPAGE_NOTLAST
net: Update the sysctl permissions handler to test effective uid/gid
net: vlan: fix nlmsg size calculation in vlan_get_size()
netvsc: don't flush peers notifying work during setting mtu
nfsd: make sure to balance get/put_write_access
nfsd: return better errors to exportfs
nfsd: split up nfsd_setattr
nfsd: when reusing an existing repcache entry, unhash it first
nfs: fix do_div() warning by instead using sector_div()
NFSv4.1: nfs4_fl_prepare_ds - fix bugs when the connect attempt fails
NFSv4: don't fail on missing fattr in open recover
NFSv4: don't reprocess cached open CLAIM_PREVIOUS
NFSv4: Fix a use-after-free situation in _nfs4_proc_getlk()
NFSv4: fix NULL dereference in open recover
NFSv4: Fix state reference counting in _nfs4_opendata_reclaim_to_nfs4_state
NFSv4: Update list of irrecoverable errors on DELEGRETURN
NFSv4 wait on recovery for async session errors
nilfs2: fix issue with race condition of competition between segments for dirty blocks
nilfs2: fix segctor bug that causes file system corruption
NTB: Add Error Handling in ntb_device_setup
NTB: Correct debugfs to work with more than 1 NTB Device
NTB: Correct Number of Scratch Pad Registers
NTB: Correct USD/DSD Identification
ntp: Make periodic RTC update more reliable
p54usb: add USB ID for Corega WLUSB2GTST USB adapter
packet: fix send path when running with proto == 0
packet: fix use after free race in send path when dev is released
parisc: break out SOCK_NONBLOCK define to own asm header file
parisc: Do not crash 64bit SMP kernels on machines with >= 4GB RAM
parisc: Ensure full cache coherency for kmap/kunmap
parisc: fix interruption handler to respect pagefault_disable()
parisc: fix mmap(MAP_FIXED|MAP_SHARED) to already mmapped address
parisc: sticon - unbreak on 64bit kernel
PCI: Allow PCIe Capability link-related register access for switches
PCI: Disable Bus Master only on kexec reboot
PCI: Remove duplicate pci_disable_device() from pcie_portdrv_remove()
PCI: Remove PCIe Capability version checks
PCI: Support PCIe Capability Slot registers only for ports with slots
perf: Fix perf ring buffer memory ordering
perf/ftrace: Fix paranoid level for enabling function tracer
perf scripting perl: Fix build error on Fedora 12
perf tools: Remove cast of non-variadic function to variadic
perf/x86/amd/ibs: Fix waking up from S3 for AMD family 10h
pinctrl: dove: unset twsi option3 for gconfig as well
{pktgen, xfrm} Update IPv4 header total len and checksum after tranformation
PM / hibernate: Avoid overflow in hibernate_preallocate_memory()
PM / runtime: Use pm_runtime_put_sync() in __device_release_driver()
powerpc/52xx: fix build breakage for MPC5200 LPBFIFO module
powerpc: Align p_end
powerpc: Fix bad stack check in exception entry
powerpc: Fix parameter clobber in csum_partial_copy_generic()
powerpc: Fix PTE page address mismatch in pgtable ctor/dtor
powerpc/gpio: Fix the wrong GPIO input data on MPC8572/MPC8536
powerpc/iommu: Use GFP_KERNEL instead of GFP_ATOMIC in iommu_init_table()
powerpc: kvm: fix rare but potential deadlock scene
powerpc/perf: Fix handling of FAB events
powerpc/powernv: Add PE to its own PELTV
powerpc: ppc64 address space capped at 32TB, mmap randomisation disabled
powerpc: Restore registers on error exit from csum_partial_copy_generic()
powerpc/signals: Improved mark VSX not saved with small contexts fix
powerpc/signals: Mark VSX not saved with small contexts
powerpc/sysfs: Disable writing to PURR in guest mode
powerpc/tm: Switch out userspace PPR and DSCR sooner
powerpc/vio: Fix modalias_show return values
powerpc/vio: use strcpy in modalias_show
prism54: set netdev type to "wlan"
proc connector: fix info leaks
qeth: avoid buffer overflow in snmp ioctl
qxl: avoid an oops in the deferred io code.
r8169: check ALDPS bit and disable it if enabled for the 8168g
r8169: enforce RX_MULTI_EN for the 8168f.
radeon: workaround pinning failure on low ram gpu
radiotap: fix bitmap-end-finding buffer overrun
raid5: avoid finding "discard" stripe
raid5: set bio bi_vcnt 0 for discard request
random32: fix off-by-one in seeding requirement
random: run random_int_secret_init() run after all late_initcalls
rbd: complete notifies before cleaning up osd_client and rbd_dev
rbd: fix a couple warnings
rbd: fix buffer size for writes to images with snapshots
rbd: fix error handling from rbd_snap_name()
rbd: fix null dereference in dout
rbd: fix use-after free of rbd_dev->disk
rbd: flush dcache after zeroing page data
rbd: ignore unmapped snapshots that no longer exist
rbd: make rbd_obj_notify_ack() synchronous
rbd: protect against concurrent unmaps
rbd: set removing flag while holding list lock
rds: prevent BUG_ON triggered on congestion update to loopback
rds: prevent dereference of a NULL device
resubmit bridge: fix message_age_timer calculation
Revert "drm/radeon: add missing hdmi callbacks for rv6xx"
Revert "ima: policy for RAMFS"
Revert "mac80211: allow disable power save in mesh"
Revert "net: update consumers of MSG_MORE to recognize MSG_SENDPAGE_NOTLAST"
Revert "of/address: Handle #address-cells > 2 specially"
rt2400pci: fix RSSI read
rt2800usb: slow down TX status polling
rt2x00: check if device is still available on rt2x00mac_flush()
rt2x00: fix a crash bug in the HT descriptor handling fix
rt2x00: fix HT TX descriptor settings regression
rt2x00: rt2800lib: fix VGC adjustment for RT5592
rtlwifi: Align private space in rtl_priv struct
rtlwifi: Fix endian error in extracting packet type
rtlwifi: pci: Fix oops on driver unload
rtlwifi: rtl8188ee: Fix smatch warning in rtl8188ee/hw.c
rtlwifi: rtl8192cu: Fix error in pointer arithmetic
rtlwifi: rtl8192cu: Fix incorrect signal strength for unassociated AP
rtlwifi: rtl8192cu: Fix more pointer arithmetic errors
rtlwifi: rtl8192de: Fix incorrect signal strength for unassociated AP
rtlwifi: rtl8192se: Fix incorrect signal strength for unassociated AP
rtlwifi: rtl8192se: Fix wrong assignment
s390/3270: fix allocation of tty3270_screen structure
s390: fix system call restart after inferior call
s390/uaccess: add missing page table walk range check
s390/vtime: correct idle time calculation
sc1200_wdt: Fix oops
sched: Avoid throttle_cfs_rq() racing with period_timer stopping
sched: Fix cfs_bandwidth misuse of hrtimer_expires_remaining
sched: Fix hrtimer_cancel()/rq->lock deadlock
sched: Fix race on toggling cfs_bandwidth_used
sched: fix the theoretical signal_wake_up() vs schedule() race
sched: Guarantee new group-entities always have weight
sched, idle: Fix the idle polling state logic
sched: numa: skip inaccessible VMAs
sched/rt: Fix rq's cpupri leak while enqueue/dequeue child RT entities
scripts/kallsyms: filter symbols not in kernel address space
SCSI: bfa: Fix crash when symb name set for offline vport
SCSI: Disable WRITE SAME for RAID and virtual host adapter drivers
SCSI: enclosure: fix WARN_ON in dual path device removing
SCSI: hpsa: do not discard scsi status on aborted commands
SCSI: hpsa: return 0 from driver probe function on success, not 1
SCSI: libsas: fix usage of ata_tf_to_fis
SCSI: sd: call blk_pm_runtime_init before add_disk
SCSI: sd: Reduce buffer size for vpd request
sctp: Perform software checksum if packet has to be fragmented.
sctp: Use software crc32 checksum when xfrm transform will happen.
selinux: correct locking in selinux_netlbl_socket_connect)
selinux: fix broken peer recv check
SELinux: Fix possible NULL pointer dereference in selinux_inode_permission()
selinux: handle TCP SYN-ACK packets correctly in selinux_ip_output()
selinux: handle TCP SYN-ACK packets correctly in selinux_ip_postroute()
selinux: look for IPsec labels on both inbound and outbound packets
selinux: process labeled IPsec TCP SYN-ACK packets properly in selinux_ip_postroute()
selinux: selinux_setprocattr()->ptrace_parent() needs rcu_read_lock()
seq_file: always update file->f_pos in seq_lseek()
serial: 8250_dw: add new ACPI IDs
serial: amba-pl011: use port lock to guard control register access
serial: pch_uart: fix tty-kref leak in dma-rx path
serial: pch_uart: fix tty-kref leak in rx-error path
serial: tegra: fix tty-kref leak
serial: vt8500: add missing braces
setfacl removes part of ACL when setting POSIX ACLs to Samba
sh: add EXPORT_SYMBOL(min_low_pfn) and EXPORT_SYMBOL(max_low_pfn) to sh_ksyms_32.c
sh: always link in helper functions extracted from libgcc
sit: allow to use rtnl ops on fb tunnel
slub: Handle NULL parameter in kmem_cache_flags
sparc32: Fix exit flag passed from traced sys_sigreturn
sparc64: Fix buggy strlcpy() conversion in ldom_reboot().
sparc64: Fix ITLB handler of null page
sparc64: Fix not SRA'ed %o5 in 32-bit traced syscall
sparc64: Fix off by one in trampoline TLB mapping installation loop.
sparc64: Remove RWSEM export leftovers
sparc: fix ldom_reboot buffer overflow harder
Staging: bcm: info leak in ioctl
staging: comedi: 8255_pci: fix for newer PCI-DIO48H
staging: comedi: addi_apci_1032: fix subdevice type/flags bug
staging: comedi: adl_pci9111: fix incorrect irq passed to request_irq()
staging: comedi: drivers: use comedi_dio_update_state() for simple cases
staging: comedi: ni_65xx: (bug fix) confine insn_bits to one subdevice
staging: comedi: pcmuio: fix possible NULL deref on detach
staging: comedi: ssv_dnp: use comedi_dio_update_state()
staging: ozwpan: prevent overflow in oz_cdev_write()
Staging: sb105x: info leak in mp_get_count()
Staging: tidspbridge: disable driver
staging: vt6656: [BUG] Fix for TX USB resets from vendors driver.
staging: vt6656: [BUG] iwctl_siwencodeext return if device not open
staging: vt6656: [BUG] main_usb.c oops on device_close move flag earlier.
staging: wlags49_h2: buffer overflow setting station name
staging: zsmalloc: Ensure handle is never 0 on success
SUNRPC: don't map EKEYEXPIRED to EACCES in call_refreshresult
SUNRPC: Fix a data corruption issue when retransmitting RPC calls
sysv: Add forgotten superblock lock init for v7 fs
target/file: Update hw_max_sectors based on current block_size
target/pscsi: fix return value check
tcp: Add missing braces to do_tcp_setsockopt
tcp: do not forget FIN in tcp_shifted_skb()
tcp: don't update snd_nxt, when a socket is switched from repair mode
tcp: fix incorrect ca_state in tail loss probe
tcp: gso: fix truesize tracking
tcp: must unclone packets before mangling them
tcp: TSO packets automatic sizing
tcp: TSQ can use a dynamic limit
tcp: tsq: restore minimal amount of queueing
team: fix master carrier set when user linkup is enabled
tg3: avoid double-freeing of rx data memory
tg3: Expand 4g_overflow_test workaround to skb fragments of any size.
tg3: Initialize REG_BASE_ADDR at PCI config offset 120 to 0
thp: fix copy_page_rep GPF by testing is_huge_zero_pmd once only
tile: use a more conservative __my_cpu_offset in CONFIG_PREEMPT
time: Fix 1ns/tick drift w/ GENERIC_TIME_VSYSCALL_OLD
tools lib lk: Uninclude linux/magic.h in debugfs.c
tracing: Allow events to have NULL strings
tracing: Fix potential out-of-bounds in trace_get_user()
tty: Fix SIGTTOU not sent with tcflush()
TTY: pmac_zilog, check existence of ports in pmz_console_init()
tuntap: correctly handle error in tun_set_iff()
tuntap: limit head length of skb allocated
tun: update file current position
uio: provide vm access to UIO_MEM_PHYS maps
uml: check length in exitcode_proc_write()
unix_diag: fix info leak
Update of blkg_stat and blkg_rwstat may happen in bh context. While u64_stats_fetch_retry is only
USB: add new zte 3g-dongle's pid to option.c
USB: cdc-acm: Added support for the Lenovo RD02-D400 USB Modem
usb: cdc-wdm: manage_power should always set needs_remote_wakeup
usb/core/devio.c: Don't reject control message to endpoint with wrong direction bit
usbcore: set lpm_capable field for LPM capable root hubs
usb: dwc3: add support for Merrifield
usb: dwc3: fix implementation of endpoint wedge
usb: dwc3: pci: add support for BayTrail
usb: fail on usb_hub_create_port_device() errors
USB: Fix breakage in ffs_fs_mount()
usb: fix cleanup after failure in hub_configure()
USB: fix PM config symbol in uhci-hcd, ehci-hcd, and xhci-hcd
USB: ftdi_sio: fixed handling of unsupported CSIZE setting
usb: gadget: composite: reset delayed_status on reset_config
usb: hub: Clear Port Reset Change during init/resume
usb: hub: Use correct reset for wedged USB3 devices that are NOTATTACHED
USB: mos7840: correct handling of CS5 setting
USB: mos7840: fix tiocmget error handling
usbnet: fix status interrupt urb handling
USB: OHCI: accept very late isochronous URBs
USB: option: support new huawei devices
USB: pl2303: fixed handling of CS5 setting
USB: quirks: add touchscreen that is dazzeled by remote wakeup
USB: quirks.c: add one device that cannot deal with suspension
USB: serial: fix race in generic write
USB: serial: ftdi_sio: add id for Z3X Box device
USB: serial: option: add support for Inovia SEW858 device
USB: serial: option: blacklist interface 1 for Huawei E173s-6
usb: serial: option: blacklist Olivetti Olicard200
USB: serial: option: Ignore card reader interface on Huawei E1750
USB: serial: ti_usb_3410_5052: add Abbott strip port ID to combined table as well.
usb: serial: zte_ev: move support for ZTE AC2726 from zte_ev back to option
USB: spcp8x5: correct handling of CS5 setting
usb-storage: add quirk for mandatory READ_CAPACITY_16
USB: support new huawei devices in option.c
USB: UHCI: accept very late isochronous URBs
vfs: allow O_PATH file descriptors for fstatfs()
vfs: fix subtle use-after-free of pipe_inode_info
vfs: In d_path don't call d_dname on a mount point
vhost/scsi: Fix incorrect usage of get_user_pages_fast write parameter
via-rhine: fix VLAN priority field (PCP, IEEE 802.1p)
video: kyro: fix incorrect sizes when copying to userspace
virtio: delete napi structures from netdev before releasing memory
virtio-net: correctly handle cpu hotplug notifier during resuming
virtio_net: don't leak memory or block when too many frags
virtio-net: don't respond to cpu hotplug notifier if we're not ready
virtio_net: fix error handling for mergeable buffers
virtio-net: fix refill races during restore
virtio-net: fix the race between channels setting and refill
virtio-net: make all RX paths handle errors consistently
virtio-net: refill only when device is up during setting queues
vlan: Fix header ops passthru when doing TX VLAN offload.
vsprintf: check real user/group id for %pK
vti: get rid of nf mark rule in prerouting
wanxl: fix info leak in ioctl
watchdog: ts72xx_wdt: locking bug in ioctl
wireless: radiotap: fix parsing buffer overrun
workqueue: fix ordered workqueues in NUMA setups
writeback: Fix data corruption on NFS
writeback: fix negative bdi max pause
X.509: Remove certificate date checks
x86-64, build: Always pass in -mno-sse
x86: avoid remapping data in parse_setup_data()
x86, build, icc: Remove uninitialized_var() from compiler-intel.h
x86, build: Pass in additional -mno-mmx, -mno-sse options
x86, efi: Don't map Boot Services on i386
x86, efi: Don't use (U)EFI time services on 32 bit
x86, fpu, amd: Clear exceptions in AMD FXSAVE workaround
x86 idle: Repair large-server 50-watt idle-power regression
x86/microcode/amd: Tone down printk(), don't treat a missing firmware file as an error
x86/reboot: Add quirk to make Dell C6100 use reboot=pci automatically
x86: Update UV3 hub revision ID
xen/blkback: fix reference counting
xen/gnttab: leave lazy MMU mode in the case of a m2p override failure
xen/hvc: allow xenboot console to be used again
xen-netback: count number required slots for an skb more carefully
xen-netback: Don't destroy the netdev until the vif is shut down
xen-netback: fix refcnt unbalance for 3.10
xen-netback: Handle backend state transitions in a more robust way
xen-netback: transition to CLOSED when removing a VIF
xen-netback: use jiffies_64 value to calculate credit timeout
xfrm: Release dst if this dst is improper for vti tunnel
xfs: add capability check to free eofblocks ioctl
xfs: fix node forward in xfs_node_toosmall
xfs: growfs overruns AGFL buffer on V4 filesystems
xfs: underflow bug in xfs_attrlist_by_handle()
xhci: Ensure a command structure points to the correct trb on the command ring
xhci: Fix oops happening after address device timeout
xhci: Fix race between ep halt and URB cancellation
xtensa: don't use alternate signal stack on threads

--------------000708010300060108040904--
